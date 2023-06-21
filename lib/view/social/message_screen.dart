import 'package:flutter/material.dart';
import 'package:while_app/resources/components/message_list_widget.dart';
import 'package:while_app/data/model/message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<MessageScreen> {
  final List<UserDetail> message = [
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Anand',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
    const UserDetail(
      title: 'Ankit',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MessageList(message: message),
    );
  }
}
