import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/profile_data_widget.dart';
import 'package:while_app/view/uploaded_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: bottom),
                        child: buildCoverImage()),
                    Positioned(
                        top: top,
                        child: Consumer<ProfileController>(
                            builder: (context, profileProvider, child) {
                        
                          return GestureDetector(
                            onTap: () {
                              profileProvider.pickImage(context);
                            },
                            child: FutureBuilder<String>(
                              future: storageReference.getDownloadURL(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                        radius: profileHeight / 2.5,
                                        backgroundColor: Colors.grey.shade800,
                                        backgroundImage: NetworkImage(
                                          snapshot.data!));
                                  } else {
                                    return CircleAvatar(
                                        radius: profileHeight / 2.5,
                                        backgroundColor: Colors.grey.shade800,
                                        backgroundImage: const NetworkImage(
                                          'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000',
                                        ));
                                  }
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          );
                        }))
                  ]),
              Column(
                children: [
                  const SizedBox(height: 8),
                  FutureBuilder(
                    future: _fetch(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Text('Loading data...Please Wait');
                      } else {
                        return Text(
                          name,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        );
                      }
                    }),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Flutter Software Engineer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton(text: 'Projects', value: 39),
                      buildDivider(),
                      buildButton(text: 'Following', value: 529),
                      buildDivider(),
                      buildButton(text: 'Followers', value: 5934),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  // Widget buildProfileImage(Provider<ProfileController> profileProvider) =>
}
