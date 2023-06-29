import 'package:flutter/material.dart';
import 'package:while_app/resources/components/chat_messages.dart';
import 'package:while_app/resources/components/new_messages.dart';
import 'package:while_app/view/social/friend_profile_screen.dart';
// import 'package:while_app/data/model/message.dart';

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen(
      {super.key,
      required this.userName,
      required this.userImage,
      required this.uid});
  final String userName;
  final String userImage;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 20,
              minRadius: 2,
              backgroundImage: NetworkImage(userImage, scale: 0.5),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => FriendProfileScreen(
                            profileImageURl: userImage,
                            userName: userName,
                          )));
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              child: Text(userName),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => FriendProfileScreen(
                          profileImageURl: userImage,
                          userName: userName,
                        )));
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatMessages(
            uid: uid,
          )),
          NewMessage(
            uid: uid,
          ),
        ],
      ),
    );
  }
}
