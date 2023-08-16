import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_compress_plus/video_compress_plus.dart';
import 'package:while_app/resources/components/round_button.dart';
import 'package:while_app/resources/components/text_container_widget.dart';
import 'package:while_app/resources/components/video_player.dart';

import 'package:while_app/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:while_app/view_model/session_controller.dart';

class AddReel extends StatefulWidget {
  final String video;
  const AddReel({Key? key, required this.video}) : super(key: key);

  @override
  State<AddReel> createState() => _AddReelState();
}

class _AddReelState extends State<AddReel> {
  late Subscription _subscription;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      debugPrint('progress: $progress');
      isloading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.unsubscribe();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  void uploadVideo(
      BuildContext context, String title, String des, String path) async {
    setState(() {
      isloading = true;
    });
    DateTime now = DateTime.now();
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('content/${FirebaseSessionController().uid!}/video/$now');
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(await _compressVideo(path));
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    final user = FirebaseAuth.instance.currentUser!;
    final docRef =
        FirebaseFirestore.instance.collection('videos').doc(user.uid);

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final List<dynamic> dynamicUrls = snapshot.data()?['urls'] ?? [];
      List<Map<String, String>> existingUrls = dynamicUrls
          .map((dynamicMap) => Map<String, String>.from(dynamicMap))
          .toList();
      existingUrls.add({'video': newUrl, 'title': title, 'description': des});
      await docRef.update({'urls': existingUrls}).then((value) {
        Utils.toastMessage('Your video is uploaded!');
        setState(() {
          isloading = false;
        });
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    } else {
      await docRef.set({
        'urls': [
          {'video': newUrl, 'title': title, 'description': des}
        ]
      }).then((value) {
        Utils.toastMessage('Your video is uploaded!');
        setState(() {
          isloading = false;
        });
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    }
  }

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality, deleteOrigin: false);
    // print(compressedVideo!.filesize);
    return compressedVideo!.file;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 1;
    final w = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reel"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: w,
                  height: h / 2,
                  child: VideoPlayerWidget(videoPath: widget.video),
                ),
              ),
              const SizedBox(height: 15),
              TextContainerWidget(
                keyboardType: TextInputType.text,
                controller: _titleController,
                prefixIcon: Icons.title,
                hintText: 'Title',
              ),
              const SizedBox(height: 10),
              TextContainerWidget(
                keyboardType: TextInputType.text,
                controller: _descriptionController,
                prefixIcon: Icons.description,
                hintText: 'Description',
              ),
              const SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: "Add Reel",
                  loading: isloading,
                  onPress: () {
                    if (_titleController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter title', context);
                    } else if (_descriptionController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter description', context);
                    } else {
                      uploadVideo(
                          context,
                          _titleController.text.toString(),
                          _descriptionController.text.toString(),
                          widget.video.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
