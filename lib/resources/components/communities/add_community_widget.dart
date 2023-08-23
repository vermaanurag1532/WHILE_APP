import 'dart:developer';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../message/apis.dart';
import '../message/models/community_user.dart';

const uuid = Uuid();

class AddCommunityScreen {
  void addCommunityDialog(BuildContext context) {
    String name = '';
    String type = '';
    String domain = '';
    String about = '';
    XFile? image;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        //title
        title: const Row(
          children: [
            Icon(
              Icons.person_add,
              color: Colors.deepPurpleAccent,
              size: 28,
            ),
            SizedBox(width: 15),
            Text('Create Community')
          ],
        ),

        //content
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //community name
            TextFormField(
              maxLines: null,
              onChanged: (value) => name = value,
              decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            //About community
            TextFormField(
              maxLines: null,
              onChanged: (value) => about = value,
              decoration: InputDecoration(
                  hintText: 'About',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            //Domain
            TextFormField(
              maxLines: null,
              onChanged: (value) => domain = value,
              decoration: InputDecoration(
                  hintText: 'Domain',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: null,
              onChanged: (value) => type = value,
              decoration: InputDecoration(
                  hintText: 'Primary/Secondary',
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  // Pick an image
                  image = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 70);
                  if (image != null) {
                    log('Image Path: ${image!.path}');

                    // await APIs.communitySendChatImage(
                    //     widget.user, File(image.path));
                  }
                },
                icon: const Icon(Icons.camera_alt_rounded,
                    color: Colors.blueAccent, size: 26)),
          ],
        ),

        //actions
        actions: [
          //cancel button
          MaterialButton(
              onPressed: () {
                //hide alert dialog
                Navigator.pop(context);
              },
              child: const Text('Discard',
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 16))),

          //add button
          MaterialButton(
              onPressed: () async {
                if (type != '' && name != '') {
                  final time = DateTime.now().millisecondsSinceEpoch.toString();
                  final String id = uuid.v4();
                  final CommunityUser community = CommunityUser(
                      image: '',
                      about: about,
                      name: name,
                      createdAt: time,
                      id: id,
                      email: APIs.me.email,
                      type: type,
                      noOfUsers: '1',
                      domain: domain,
                      admin: APIs.me.name);
                  APIs.addCommunities(community, File(image!.path));

                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
