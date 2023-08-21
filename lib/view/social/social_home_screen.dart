import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/home_screen.dart';
import 'package:while_app/view/social/community_screenn.dart';
import 'package:while_app/view/social/notification.dart';

import '../../resources/components/communities/test.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({
    super.key,
  });

  @override
  State<SocialScreen> createState() {
    return _SocialScreenState();
  }
}

class _SocialScreenState extends State<SocialScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool isSearching = false;
  var value = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    void addCommunityDialog() {
      String name = '';
      String type = '';
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
              const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

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

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          //if search is on & back button is pressed then close search
          //or else simple close current screen on back button click
          onWillPop: () {
            if (isSearching) {
              setState(() {
                isSearching = !isSearching;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              title: isSearching
                  ? TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name, Email, ...',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(142, 255, 255, 255),
                          )),
                      autofocus: true,
                      style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                      //when search text changes then updated search list
                      onChanged: (val) {
                        //search logic
                        setState(() {
                          value = val;
                        });
                      },
                    )
                  : const Text('Social'),
              actions: [
                IconButton(
                    onPressed: () {
                      addCommunityDialog();
                    },
                    icon: const Icon(Icons.group_add)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const NotificationScreen()));
                    },
                    icon: const Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (ctx) => const Search()));
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    icon: const Icon(Icons.search)),
                PopupMenuButton(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: "newgroup",
                          child: Text('New Group'),
                        ),
                        PopupMenuItem(
                          child: const Text('New community'),
                          onTap: () {
                            log('pop up button pressed');
                            addCommunityDialog();
                          },
                        ),
                        const PopupMenuItem(child: Text('New Group')),
                        const PopupMenuItem(child: Text('New Group')),
                      ];
                    })
              ],
              bottom: TabBar(
                controller: _controller,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    text: 'Status',
                  ),
                  Tab(
                    text: 'Chats',
                  ),
                  Tab(
                    text: 'Community',
                  ),
                  Tab(
                    text: 'Calls',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                const CommunityScreenFinal(
                  isSearching: true,
                  value: '',
                ),
                HomeScreenFinal(
                  isSearching: isSearching,
                  value: value,
                ),
                const CommunityScreen(
                  isSearching: true,
                  value: '',
                ),
                const Text('Callsss'),
              ],
            ),
          ),
        ));
  }
}
