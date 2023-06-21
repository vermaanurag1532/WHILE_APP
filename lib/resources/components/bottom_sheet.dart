import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:while_app/view_model/image_provider.dart';

class Bottomsheet extends StatefulWidget {
  final String check;
  const Bottomsheet({super.key,required this.check});
  

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final ImagePicker picker = ImagePicker();
  var imageFile;

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<Imageprovider>(context, listen: false);

    Future<void> takePhoto(ImageSource source) async {
      var pickedFile = await picker.pickImage(source: source);
      File file = File(pickedFile!.path);
      widget.check=="p"? image.setProfile(file): image.setBg(file);
    }

    var w = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile photo",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.blueAccent,
                    )),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.blueAccent),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          takePhoto(ImageSource.camera);
                        },
                        icon: const Icon(
                          Icons.photo_camera,
                          size: 30,
                          color: Colors.blueAccent,
                        ))),
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.blueAccent),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          takePhoto(ImageSource.gallery);
                        },
                        icon: const Icon(
                          Icons.photo,
                          size: 30,
                          color: Colors.blueAccent,
                        )))
              ],
            )
          ],
        ));
  }
}
