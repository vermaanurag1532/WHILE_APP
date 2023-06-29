import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_app/view/social/message_detail.dart';
import 'package:while_app/view/social/social_home_screen.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _MyAppState();
}

class _MyAppState extends State<Search> {
  String name = "";

  add() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      final user = FirebaseAuth.instance.currentUser!;
                      var uid = '';
                      bool functionCallComplete = false;
                      void navigate() {
                        if (uid != '') {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MessageDetailScreen(
                                  userName: data['name'],
                                  userImage: data['profile'],
                                  uid: uid)));
                        } else {}
                        print('navigated');
                        print(uid);
                      }

                      void addFriend() async {
                        bool fr = false;

                        var n = await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user.uid)
                            .collection('followers')
                            .get();
                        int k = n.docs.length.toInt();

                        for (int i = 0; i < k; i++) {
                          if (snapshots.data!.docs[index].id ==
                              n.docs[i].get('uid')) {
                            fr = true;
                            uid = n.docs[i].id;
                            navigate();
                            print(uid);
                            break;
                          }
                        }

                        if (fr == false) {
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user.uid)
                              .collection('followers')
                              .add({
                            'friendName': data['name'],
                            'uid': snapshots.data!.docs[index].id,
                            'profile': data['profile'],
                          });

                          var userData = await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user.uid)
                              .get();
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(snapshots.data!.docs[index].id)
                              .collection('followers')
                              .add({
                            'friendName': userData.data()!['name'],
                            'uid': user.uid,
                            'profile': userData.data()!['profile'],
                          });
                          for (int i = 0; i <= k; i++) {
                            print(i);
                            if (snapshots.data!.docs[index].id ==
                                n.docs[i].get('uid')) {
                              uid = n.docs[i].id;
                              print('hurrraaay');
                              navigate();
                              break;
                            }
                          }
                        }
                        functionCallComplete = true;
                        print(functionCallComplete);
                      }

                      if (name.isEmpty) {
                        return ListTile(
                          onTap: () {
                            addFriend();
                            print('not wait');

                            if (functionCallComplete) {
                              print('navigator called');
                            }

                            // Navigator.of(context).pop(message);
                          },
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['profile']),
                          ),
                          trailing: OutlinedButton(
                            onPressed: () {},
                            child: Text('Follow'),
                            style: OutlinedButton.styleFrom(
                                elevation: 2,
                                primary: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(162, 15, 60, 165)),
                          ),
                        );
                      }
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return ListTile(
                          onTap: () {
                            addFriend();
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['profile']),
                          ),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
