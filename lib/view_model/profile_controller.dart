import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/resources/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:while_app/utils/utils.dart';
import 'package:while_app/view_model/session_controller.dart';

class ProfileController with ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.reference();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                height: 120,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        pickCameraImage(context);
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.camera, color: AppColors.theme1Color),
                      title: Text('Camera'),
                    ),
                    ListTile(
                      onTap: () {
                        pickGalleryImage(context);
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.image, color: AppColors.theme1Color),
                      title: Text('Gallery'),
                    ),
                  ],
                )),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + FirebaseSessionController().uid!.toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref
        .child(FirebaseSessionController().uid.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      setLoading(true);
      _image = null;
      Utils.toastMessage('Profile Updated');
    }).onError((error, stackTrace) {
      setLoading(true);
      Utils.toastMessage(error.toString());
    });
  }
}
