import 'package:flutter/material.dart';
import 'package:while_app/data/model/community.dart';
import 'package:while_app/resources/components/community_list_widget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _CommunityScreenState();
  }
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<CommunityDetail> message = [
    const CommunityDetail(
      title: 'Python',
      image:
          'https://cdn.dribbble.com/users/677572/screenshots/15183178/media/a18bc2af7f14f9f36b96f27af1be9865.png?compress=1&resize=1000x750&vertical=center',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommunityList(message: message),
    );
  }
}
