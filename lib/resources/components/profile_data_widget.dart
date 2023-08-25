import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'bottom_options_sheet.dart';

late Size mq;

class ProfileDataWidget extends StatefulWidget {
  const ProfileDataWidget({super.key});

  @override
  State<ProfileDataWidget> createState() => _ProfileDataWidgetState();
}

class _ProfileDataWidgetState extends State<ProfileDataWidget> {
  String? _image;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

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
                child: ClipRRect(
              // borderRadius: BorderRadius.circular(h * .13),
              child: CachedNetworkImage(
                width: h,
                fit: BoxFit.cover,
                height: h * .13,
                imageUrl: APIs.me.image,
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(CupertinoIcons.person)),
              ),
            )),
          ),
          Positioned(
            top: nh + h / 7 - w / 8,
            left: w / 12,
            child: Stack(
              children: [
                //profile picture
                _image != null
                    ?

                    //local image
                    ClipRRect(
                        borderRadius: BorderRadius.circular(h * .1),
                        child: Image.file(File(_image!),
                            width: h * .1, height: h * .1, fit: BoxFit.cover))
                    :

                    //image from server
                    ClipRRect(
                        borderRadius: BorderRadius.circular(h * .1),
                        child: CachedNetworkImage(
                          width: h * .15,
                          height: h * .15,
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.fill,
                          imageUrl: APIs.me.image,
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                      ),

                //edit image button
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: MaterialButton(
                    elevation: 1,
                    onPressed: () {
                      _showBottomSheet();
                    },
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: const Icon(Icons.edit, color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
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
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const MoreOptions();
                        });
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ))),
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
            top: nh + h / 7 + w / 8 + 30,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    APIs.me.id,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  Text(APIs.me.about,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: mq.height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(
                        Icons.image,
                        color: Colors.black,
                        size: mq.width * .2,
                      )),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
