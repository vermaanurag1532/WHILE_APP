import 'dart:developer';
import 'package:flutter/material.dart';
import '../message/apis.dart';
import '../message/helper/dialogs.dart';
import '../message/models/community_user.dart';
import '../message/widgets/community_user_card.dart';

late Size mq;

//home screen -- where all available contacts are shown
class CommunityScreenFinal extends StatefulWidget {
  const CommunityScreenFinal(
      {super.key, required this.isSearching, required this.value});
  final bool isSearching;
  final String value;

  @override
  State<CommunityScreenFinal> createState() => _CommunityScreenFinalState();
}

class _CommunityScreenFinalState extends State<CommunityScreenFinal> {
  // for storing all users

  // for storing searched items

  // for storing search status
  List<CommunityUser> _list = [];
  final List<CommunityUser> _searchList = [];
  @override
  void initState() {
    super.initState();
    // APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    // SystemChannels.lifecycle.setMessageHandler((message) {
    //   log('Message: $message');

    //   if (APIs.auth.currentUser != null) {
    //     if (message.toString().contains('resume')) {
    //       APIs.updateActiveStatus(true);
    //     }
    //     if (message.toString().contains('pause')) {
    //       APIs.updateActiveStatus(false);
    //     }
    //   }

    //   return Future.value(message);
    // });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = widget.isSearching;
    isSearching = false;
    if (widget.value != '') {
      log(widget.value);
      _searchList.clear();

      for (var i in _list) {
        if (i.name.toLowerCase().contains(widget.value.toLowerCase()) ||
            i.email.toLowerCase().contains(widget.value.toLowerCase())) {
          _searchList.add(i);
          setState(() {
            _searchList;
          });
        }
      }
    }

    mq = MediaQuery.of(context).size;
    return Scaffold(
      //floating button to add new user

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () {
              _addChatUserDialog();
            },
            child: const Icon(Icons.add_comment_rounded)),
      ),

      //body
      body: StreamBuilder(
        stream: APIs.getCommunityId(),

        //get id of only known users
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              return StreamBuilder(
                stream: APIs.getAllUserCommunities(
                    snapshot.data?.docs.map((e) => e.id).toList() ?? []),

                //get only those communities, who's ids are provided
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;

                      _list = data
                              ?.map((e) => CommunityUser.fromJson(e.data()))
                              .toList() ??
                          [];
                      log(_list.toString());

                      if (_list.isNotEmpty) {
                        log('//////////////////////');
                        log(_list.length.toString());
                        log(isSearching.toString());
                        return ListView.builder(
                            itemCount:
                                isSearching ? _searchList.length : _list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatCommunityCard(
                                  user: isSearching
                                      ? _searchList[index]
                                      : _list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text('No Connections Found!',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              );
          }
        },
      ),
    );
  }

  // for adding new chat user
  void _addChatUserDialog() {
    String email = '';

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
            Text('  Add User')
          ],
        ),

        //content
        content: TextFormField(
          maxLines: null,
          onChanged: (value) => email = value,
          decoration: InputDecoration(
              hintText: 'Email Id',
              prefixIcon: const Icon(Icons.email, color: Colors.blue),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),

        //actions
        actions: [
          //cancel button
          MaterialButton(
              onPressed: () {
                //hide alert dialog
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 16))),

          //add button
          MaterialButton(
              onPressed: () async {
                //hide alert dialog
                Navigator.pop(context);
                if (email.isNotEmpty) {
                  await APIs.addChatUser(email).then((value) {
                    if (!value) {
                      Dialogs.showSnackbar(context, 'User does not Exists!');
                    }
                  });
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
