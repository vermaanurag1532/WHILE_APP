import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_app/data/model/message.dart';
import 'package:while_app/view/social/social_home_screen.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _MyAppState();
}

class _MyAppState extends State<Search> {
  String name = "";
  List<UserDetail> message = [];

  add() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return ListTile(
                          onTap: () {
                            message = [UserDetail(username: data['name'])];
                            final user = FirebaseAuth.instance.currentUser!;
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(user.uid)
                                .collection('followers')
                                .add({
                              'friendName': data['name'],
                              'uid': snapshots.data!.docs[index].id,
                              'profile': data['profile'],
                            });

                            // Navigator.of(context).pop(message);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    SocialScreen(message: message)));
                          },
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['profile']),
                          ),
                        );
                      }
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['profile']),
                          ),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
