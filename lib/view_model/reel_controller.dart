import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class ReelController with ChangeNotifier {
  final picker = ImagePicker();
  late File _selectedVideo;

  File get selectedVideo => _selectedVideo;

  Future<void> selectVideo(BuildContext context) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Select Video Source"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickVideo(source: source);
      if (pickedFile != null) {
        // _selectedVideo = File(pickedFile.path);
        Navigator.pushNamed(context, RoutesName.addReel, arguments:pickedFile.path);
        notifyListeners();
      }
    }
  }

//   final databaseReference = FirebaseDatabase.instance.reference();
//   DatabaseReference ref = FirebaseDatabase.instance.ref().child('Reels');
//   firebase_storage.FirebaseStorage storage =
//   firebase_storage.FirebaseStorage.instance;


// XFile? _video;
// XFile? get video=>_video;
// final picker=ImagePicker();

// Future pickGalleryVideo(BuildContext context)async{
//   _video=await picker.pickVideo(source: ImageSource.gallery);
//   print("andar2");

//   notifyListeners();
// }

}