import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_app/resources/components/bottom_sheet.dart';
import 'package:while_app/view_model/profile_controller.dart';
import '../../repository/firebase_repository.dart';
import 'bottom_options_sheet.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({super.key});

 

  @override
  Widget build(BuildContext context) {
    FirebaseAuthMethods authMethods = FirebaseAuthMethods(FirebaseAuth.instance);

    final profile = Provider.of<ProfileController>(context);
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
                        return const Bottomsheet(tx: "Cover picture",);
                      });
                },
                child: Container(
                  height: h / 7,
                  width: w,
                  color: Colors.grey,
                  child: profile.bgimage == null
                      ? null
                      : Image(
                          fit: BoxFit.cover,
                          image: FileImage(profile.bgimage!)),
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
                        return const Bottomsheet(tx: "Profile Picture",);
                      });
                },
                child: CircleAvatar(
                  backgroundImage: profile.profileimage == null
                      ? null
                      : FileImage(profile.profileimage!),
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
            top: nh + h / 7 + w / 8 + 30,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(authMethods.user.email!),
                  const Text(
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
