
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
     final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
        bool loading=false;

          void uploadVideo(
      BuildContext context, String title, String des, String path) async {
    DateTime now = DateTime.now();
    setState(() {
        loading = true;
      });
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('content/${FirebaseSessionController().uid!}/video/$now');
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    final user = FirebaseAuth.instance.currentUser!;
    final docRef =
        FirebaseFirestore.instance.collection('videos').doc(user.uid);

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      List<Map<String,String>> existingUrls =
          List<Map<String,String>>.from(snapshot.data()?['urls'] ?? []);
      existingUrls.add({'video':newUrl,'title':title,'description':des});
      await docRef.update({'urls': existingUrls}).then((value) {
       setState(() {
        loading = false;
      });
      Utils.toastMessage('Your video is uploaded!');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils.toastMessage(error.toString());
    });
    } else {
      await docRef.set({
        'urls': [{'video':newUrl,'title':title,'description':des}]
      }).then((value) {
       setState(() {
        loading = false;
      });
      Utils.toastMessage('Your video is uploaded!');
    }).onError((error, stackTrace) {
     setState(() {
        loading = false;
      });
      Utils.toastMessage(error.toString());
    });
    }}
  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height * 1;
    final w = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Reel"),
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
            height: h/2,
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
                  title: 'Add Reel',
                  loading: loading,
                  onPress: () async {
                    if (_titleController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter title', context);
                    } else if (_descriptionController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter description', context);
                    } else {
                            uploadVideo(context, _titleController.text.toString(),
                              _descriptionController.text.toString(),widget.video.toString());
                    }
                    
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
