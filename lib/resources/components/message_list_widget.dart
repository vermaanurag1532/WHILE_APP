import 'package:flutter/material.dart';
import 'package:while_app/data/model/message.dart';
import 'package:while_app/view/social/message_detail.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.message});
  final List<UserDetail> message;
  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) {
      return Center(
        child: Text(
          'No Message is added yet',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return Scaffold(
      body: ListView.builder(
          itemCount: message.length,
          itemBuilder: (ctx, index) => ListTile(
                leading: CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage(message[index].image),
                ),
                title: Text(
                  message[index].title,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => MessageDetailScreen(
                      userName: message[index].title,
                      userImage: message[index].image,
                    ),
                  ));
                },
                contentPadding: const EdgeInsets.only(top: 15, left: 2),
              )),
    );
  }
}
