import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../message/apis.dart';
import '../message/models/community_user.dart';

class AddCommunityScreen {
  final CommunityUser community = CommunityUser(
      image: '',
      about: '',
      name: '',
      createdAt: '',
      id: '',
      email: '',
      type: '',
      noOfUsers: '',
      domain: '');

  void addCommunityDialog(BuildContext context) {
    String name = '';
    String type = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        //title
        title: const Row(
          children: [
            Icon(
              Icons.person_add,
              color: Colors.blue,
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
                  hintText: 'Community Name',
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(
              height: 10,
            ),
            //About community
            TextFormField(
              maxLines: null,
              onChanged: (value) => type = value,
              decoration: InputDecoration(
                  hintText: 'Primary/Secondary',
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
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
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
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
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
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
                  style: TextStyle(color: Colors.blue, fontSize: 16))),

          //add button
          MaterialButton(
              onPressed: () async {
                if (type != '' && name != '') {
                  await FirebaseFirestore.instance
                      .collection('communities')
                      .add({
                    'name': name,
                    'type': type,
                    'admin': APIs.me.name,
                    'lastMessage': ''
                  }).then((value) {
                    log(value.id);
                    FirebaseFirestore.instance
                        .collection('communities')
                        .doc(value.id)
                        .update({
                      'id': value.id,
                    });
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
