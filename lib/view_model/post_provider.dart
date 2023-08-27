import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/utils/routes/routes_name.dart';
import 'package:while_app/view_model/session_controller.dart';

class PostProvider extends ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.reference();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  ImagePicker imagePicker = ImagePicker();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  File? _post;
  File? get post => _post;

  LoadValue(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  selectPost(BuildContext context) async {
    final source = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: const Text("Select Video Source"),
              actions: [
                ListTile(
                  title: const Text("Camera"),
                  leading: const Icon(Icons.photo_camera),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
                ListTile(
                  title: const Text("Gallery"),
                  leading: const Icon(Icons.photo),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                )
              ]);
        });
    if (source != null) {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4
          ],
        );
        if (croppedFile != null) {
          _post = File(croppedFile.path);
          notifyListeners();
          if (context.mounted) {
            Navigator.pushNamed(context, RoutesName.postPreview,
                arguments: File(croppedFile.path));
          }
        }
      }
    }
  }

  postImage(String caption) async {
    LoadValue(true);
    final datetime = DateTime.now();
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('content/${FirebaseSessionController().uid}/post/$datetime');
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(post!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = storageRef.getDownloadURL();
    FirebaseFirestore.instance
        .collection('posts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FirebaseAuth.instance.currentUser!.email!).add({
          "caption": caption,
          "postUrl": newUrl
        });
  }
}
