import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:while_app/view_model/profile_controller.dart';

class Bottomsheet extends StatefulWidget {
  final String tx;
  const Bottomsheet({super.key,required this.tx });

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileController>(context, listen: false);

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
                Text(
                  widget.tx,
                  style:const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
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
                          profile.pickCameraImage(context, widget.tx);
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
                          profile.pickGalleryImage(context, widget.tx);
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
