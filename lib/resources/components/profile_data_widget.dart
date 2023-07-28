import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/bottom_sheet.dart';
import '../../view_model/session_controller.dart';
import 'bottom_options_sheet.dart';

class ProfileDataWidget extends StatefulWidget {
  const ProfileDataWidget({super.key});

  @override
  State<ProfileDataWidget> createState() => _ProfileDataWidgetState();
}

class _ProfileDataWidgetState extends State<ProfileDataWidget> {
  @override
  Widget build(BuildContext context) {
    var name = "";
    _fetch() async {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(firebaseUser.uid)
            .get()
            .then((ds) {
          if (ds.exists) {
            name = ds.data()!['name'];
          } else {
            // print(ds.data());
            // print("User not found");
          }
        }).catchError((e) {
          // print(e);
        });
      }
    }

    final Reference storageReference = FirebaseStorage.instance.ref();

    final profilerefrence = storageReference
        .child('/profileImage${FirebaseSessionController().uid}');
    final coverreference =
        storageReference.child('/bgImage${FirebaseSessionController().uid}');

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
                          tx: "Cover picture",
                        );
                      });
                },
                child: Container(
                    height: h / 7,
                    width: w,
                    color: Colors.grey,
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot.data!));
                          }
                          return const Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000'));
                        }
                        return const Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000'));
                      },
                      future: coverreference.getDownloadURL(),
                    )),
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
                            tx: "Profile Picture",
                          );
                        });
                  },
                  child: FutureBuilder(
                    future: profilerefrence.getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data!),
                            radius: w / 8,
                          );
                        }
                        return CircleAvatar(
                          backgroundImage: const NetworkImage(
                              'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000'),
                          radius: w / 8,
                        );
                      }
                      return CircleAvatar(
                        backgroundImage: const NetworkImage(
                            'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000'),
                        radius: w / 8,
                      );
                    },
                  ))),
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
                  FutureBuilder(
                    future: _fetch(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        );
                      }
                      return const Text("loading data please wait");
                    }),
                  ),
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
