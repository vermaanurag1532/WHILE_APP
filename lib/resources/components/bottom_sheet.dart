import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({super.key});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final ImagePicker picker = ImagePicker();
  var imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 5,
              color: Colors.grey,
              width: 50,
            ),
            const SizedBox(
              height: 15,
            ),
            CircleAvatar(
              backgroundImage: imageFile==null? null : FileImage(imageFile),
              radius: 25,
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_outlined,
                size: 40,
                color: Colors.black,
              ),
              title:const Text("New profile picture"),
              onTap: () {
                takePhoto(ImageSource.gallery);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_outlined,
                size: 40,
                color: Colors.black,
              ),
               title:const Text("Camera"),
              onTap: () {
                takePhoto(ImageSource.camera);
              },
            ),
          ],
        ));
  }

  Future<void> takePhoto(ImageSource source) async {
    var pickedFile = await picker.pickImage(source: source);
    File file = File(pickedFile!.path);
    setState(() {
      imageFile = file;
    });
  }
}
