import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:while_app/view/social/community_detail.dart';
import '../../resources/components/message/apis.dart';
import '../../resources/components/message/helper/dialogs.dart';
import '../../resources/components/message/models/chat_user.dart';

late Size mq;

//home screen -- where all available contacts are shown
class CommunityScreen extends StatefulWidget {
  const CommunityScreen(
      {super.key, required this.isSearching, required this.value});
  final bool isSearching;
  final String value;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // for storing all users

  // for storing searched items

  // for storing search status
  final List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
              onPressed: () {
                _addCommunityDialog();
              },
              child: const Icon(Icons.add_comment_rounded)),
        ),

        //body
        body: StreamBuilder(
            stream: APIs.getCommunityId(),
            //get id of only known users
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data();
                        var name = '';
                        var lastMsg = '';

                        communityData() async {
                          var datas = await APIs.getCommunityDetail(data['id']);
                          name = datas['name'];
                          lastMsg = datas['lastMessage'];
                        }

                        return FutureBuilder(
                          future: communityData(),
                          builder: (context, snapshots) {
                            return Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: mq.width * .04, vertical: 4),
                                color: Colors.white,
                                elevation: 2.5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          CommunityDetailScreen(
                                        userImage: '',
                                        userName: name,
                                        id: data['id'],
                                      ),
                                    ));
                                  },
                                  title: Text(
                                    name,
                                    textAlign: TextAlign.center,
                                  ),
                                  subtitle: Text(lastMsg,
                                      textAlign: TextAlign.center),
                                ));
                          },
                        );
                      },
                    );
            }));
  }

  // for adding new chat user
  void _addCommunityDialog() {
    String name = '';

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
              color: Colors.deepPurpleAccent,
              size: 28,
            ),
            Text('Add Community')
          ],
        ),

        //content
        content: TextFormField(
          maxLines: null,
          onChanged: (value) => name = value,
          decoration: InputDecoration(
              hintText: 'Community Name',
              prefixIcon:
                  const Icon(Icons.email, color: Colors.deepPurpleAccent),
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
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 16))),

          //add button
          MaterialButton(
              onPressed: () async {
                //hide alert dialog
                Navigator.pop(context);
                if (name.isNotEmpty) {
                  await APIs.addCommunity(name).then((value) {
                    if (!value) {
                      Dialogs.showSnackbar(
                          context, 'Community does not Exists!');
                    }
                  });
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
