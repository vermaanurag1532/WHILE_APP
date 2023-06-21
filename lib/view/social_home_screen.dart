import 'package:flutter/material.dart';
import 'package:while_app/view/community_screenn.dart';
import 'package:while_app/view/message_screen.dart';
import 'package:while_app/view/social/story_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() {
    return _TestScreenState();
  }
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Social'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    value: "newgroup",
                    child: Text('New Group'),
                  ),
                  PopupMenuItem(child: Text('New Group')),
                  PopupMenuItem(child: Text('New Group')),
                  PopupMenuItem(child: Text('New Group')),
                ];
              })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Chats',
            ),
            Tab(
              text: 'Community',
            ),
            Tab(
              text: 'Calls',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          StoryScreen(),
          MessageScreen(),
          CommunityScreen(),
          Text('Calls'),
        ],
      ),
    );
  }
}
