import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/resources/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

class ProfileController with ChangeNotifier {

  
final databaseReference = FirebaseDatabase.instance.reference();
// DatabaseReference ref=FirebaseDatabase.instance.ref().child('Users');
// firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
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

  void uploadImage(String userId, String name, String email){

   databaseReference.child('users').child(userId).set({
    'name': name,
    'email': email,
  });

  }
}
