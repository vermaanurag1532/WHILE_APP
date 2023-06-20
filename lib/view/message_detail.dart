import 'package:flutter/material.dart';
// import 'package:while_app/data/model/message.dart';

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen(
      {super.key, required this.userName, required this.userImage});
  final String userName;
  final String userImage;
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
            ),
            const SizedBox(
              width: 20,
            ),
            Text(userName),
          ],
        ),
      ),
      body: const Center(child: Text('message')),
    );
  }
}
