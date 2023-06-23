import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/view/social/message_detail.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('followers')
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

                  return ListTile(
                    title: Text(data['friendName']),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MessageDetailScreen(
                          userName: data['friendName'],
                          userImage: data['profile'],
                          uid: snapshot.data!.docs[index].id,
                        ),
                      ));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['profile']),
                    ),
                  );
                },
              );
      },
    );
  }
}
