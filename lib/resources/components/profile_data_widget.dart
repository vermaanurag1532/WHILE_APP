import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_app/resources/components/bottom_sheet.dart';
import 'package:while_app/view_model/image_provider.dart';
import 'bottom_options_sheet.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<Imageprovider>(context);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var nh = MediaQuery.of(context).viewPadding.top;
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: h / 2.5,
          ),
          Positioned(
              top: nh,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const Bottomsheet(
                          check: "b",
                        );
                      });
                },
                child: Container(
                  height: h / 7,
                  width: w,
                  color: Colors.blue,
                  child: image.bgImage == null
                      ? null
                      : Image(
                          fit: BoxFit.cover, image: FileImage(image.bgImage!)),
                ),
              )),
          Positioned(
              top: nh + h / 7 - w / 8,
              left: w / 12,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const Bottomsheet(
                          check: "p",
                        );
                      });
                },
                child: CircleAvatar(
                  backgroundImage: image.profileImage == null
                      ? null
                      : FileImage(image.profileImage!),
                  radius: w / 8,
                ),
              )),
          Positioned(
              top: nh + h / 7 + 5,
              left: w / 2.5,
              child: const Text(
                "Followers",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 + 5,
              left: w / 1.5,
              child: const Text(
                "Following",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7.5,
              left: w / 1.15,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const MoreOptions();
                        });
                  },
                  icon: const Icon(Icons.more_vert))),
          Positioned(
              top: nh + h / 7 + 24,
              left: w / 2.5,
              child: const Text(
                "300",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 + 24,
              left: w / 1.5,
              child: const Text(
                "320",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
            top: nh + h / 7 + w / 8 + 20,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ankit Pandit",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      'My name is Ankit Kumar Dwivedi, I am founder \n'
                      'and CEO of WHILE NETWORKS Private LTD.',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
