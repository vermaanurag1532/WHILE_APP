import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'communities_chat_messages.dart';
import 'communities_new_messages.dart';

class CommunitiesChatScreen extends StatefulWidget {
  const CommunitiesChatScreen({super.key, required this.id});
  final String id;

  @override
  State<CommunitiesChatScreen> createState() => _CommunitiesChatScreenState();
}

class _CommunitiesChatScreenState extends State<CommunitiesChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(209, 196, 233, 1),
      body: Column(
        children: [
          Expanded(
              child: ChatMessages(
            id: widget.id,
          )),
          NewMessage(
            id: widget.id,
          ),
        ],
      ),
    );
  }
}
