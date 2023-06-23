import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key, required this.uid});
  final String uid;
  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    // FocusScope.of(context).unfocus();
    _messageController.clear();
    // send to firebase

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('followers')
        .doc(widget.uid)
        .get();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('followers')
        .doc(widget.uid)
        .collection('message')
        .add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['friendName'],
      'userImage': userData.data()!['profile'],
    });

    var n = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userData.data()!['uid'])
        .collection('followers')
        .get();
    int k = n.docs.length.toInt();

    for (int i = 0; i < k; i++) {
      if (n.docs[i].get('uid') == user.uid) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(userData.data()!['uid'])
            .collection('followers')
            .doc(n.docs[i].id)
            .collection('message')
            .add({
          'text': enteredMessage,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          // 'username': userData.data()!['friendName'],
          // 'userImage': userData.data()!['profile'],
        });

        break;
      }
    }

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userData.data()!['uid'])
        .collection('followers')
        .doc(widget.uid)
        .collection('message')
        .add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      // 'username': userData.data()!['friendName'],
      // 'userImage': userData.data()!['profile'],
    });

    //close keyboard
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 1,
        bottom: 14,
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: 'Send a message ...'),
          ),
        ),
        IconButton(
            onPressed: _submitMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ))
      ]),
    );
  }
}
