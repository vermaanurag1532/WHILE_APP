import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/friend_profile_data_widget%20.dart';
import 'package:while_app/view/uploaded_screen.dart';

// ignore: must_be_immutable
class FriendProfileScreen extends StatelessWidget {
  FriendProfileScreen({
    super.key,
    required this.uid,
  });
  String uid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate([
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return FriendProfileDataWidget(
                        profileImageURl: snapshot.data!['profile'],
                        userName: snapshot.data!['name'],
                      );
                    },
                  )
                ]))
              ];
            },
            body: const Column(
              children: [
                Material(
                  child: TabBar(
                      padding: EdgeInsets.all(0),
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(
                            icon: Icon(Icons.photo_outlined,
                                color: Colors.black, size: 30)),
                        Tab(
                            icon: Icon(Icons.person,
                                color: Colors.black, size: 30)),
                        Tab(
                            icon: Icon(Icons.brush,
                                color: Colors.black, size: 30))
                      ]),
                ),
                Expanded(
                    child: TabBarView(children: [
                  UploadedScreen(),
                  Text("second"),
                  Text("third")
                ]))
              ],
            ),
          )),
    );
  }
}
