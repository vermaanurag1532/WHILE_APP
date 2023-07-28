// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _MyAppState();
}

class _MyAppState extends State<NotificationScreen> {
  String name = "";
  final user = FirebaseAuth.instance.currentUser!;

  add() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .collection('notification')
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data();
                    if (data.isNotEmpty) {
                      return ListTile(
                          title: Text(data['text']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['profile']),
                          ),
                          trailing: OutlinedButton(
                            onPressed: () {
                              // addFriend();
                            },
                            style: OutlinedButton.styleFrom(
                                elevation: 2,
                                // primary: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(162, 15, 60, 165)),
                            child: const Text('Follow Back'),
                            // child: FutureBuilder(
                            //     future: check(),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData) {
                            //         return Text(snapshot.data!);
                            //       }
                            //       return Text('Nodata');
                            //     }),
                          ));
                    }
                    return const Text('No Notification');
                  },
                );
        },
      ),
    );
  }
}
