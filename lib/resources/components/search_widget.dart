// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:while_app/view/social/friend_profile_screen.dart';
// import 'package:while_app/view_model/current_user_provider.dart';

// class SearchWidget extends StatefulWidget {
//   const SearchWidget({
//     super.key,
//     required this.snapshots,
//     required this.name,
//   });
//   // ignore: prefer_typing_uninitialized_variables
//   final snapshots;
//   final String name;
//   @override
//   State<StatefulWidget> createState() {
//     return _SearchWidgetState();
//   }
// }

// class _SearchWidgetState extends State<SearchWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: widget.snapshots.data!.docs.length,
//         itemBuilder: (context, index) {
//           var data =
//               widget.snapshots.data!.docs[index].data() as Map<String, dynamic>;

//           // final user = FirebaseAuth.instance.currentUser!;
//           var userProvider = Provider.of<CurrentUserProvider>(context);
//           var uid = '';
//           // ignore: unused_local_variable
//           var alreadyFriend = '';
//           check() async {
//             String isFollowing = 'Follow';
//             var n = await FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(userProvider.user.uid)
//                 .collection('following')
//                 .get();
//             int k = n.docs.length.toInt();

//             for (int i = 0; i < k; i++) {
//               if (widget.snapshots.data!.docs[index].id ==
//                   n.docs[i].get('uid')) {
//                 isFollowing = 'Message';
//                 break;
//               }
//             }
//             return isFollowing;
//           }

//           void navigate() async {
//             var n = await FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(userProvider.user.uid)
//                 .collection('followers')
//                 .get();
//             int k = n.docs.length.toInt();
//             for (int i = 0; i < k; i++) {
//               if (widget.snapshots.data!.docs[index].id ==
//                   n.docs[i].get('uid')) {
//                 uid = n.docs[i].id;
//                 break;
//               }
//             }
//             if (uid != '') {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (ctx) => MessageDetailScreen(
//               //         userName: data['name'],
//               //         userImage: data['profile'],
//               //         friendUid: uid,
//               //         uid: uid)));
//             } else {}
//           }

//           void addFriend() async {
//             var n = await FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(userProvider.user.uid)
//                 .collection('following')
//                 .get();

//             for (int i = 0; i < n.docs.length.toInt(); i++) {
//               if (widget.snapshots.data!.docs[index].id ==
//                   n.docs[i].get('uid')) {
//                 uid = n.docs[i].id;
//                 navigate();

//                 break;
//               }
//             }

//             FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(userProvider.user.uid)
//                 .collection('following')
//                 .add({
//               'friendName': data['name'],
//               'uid': widget.snapshots.data!.docs[index].id,
//               'profile': data['profile'],
//               'isFollowing': true,
//             });

//             var userData = await FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(userProvider.user.uid)
//                 .get();
//             FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(widget.snapshots.data!.docs[index].id)
//                 .collection('followers')
//                 .add({
//               'friendName': userData.data()!['name'],
//               'uid': userProvider.user.uid,
//               'profile': userData.data()!['profile'],
//             });
//             FirebaseFirestore.instance
//                 .collection('Users')
//                 .doc(widget.snapshots.data!.docs[index].id)
//                 .collection('notification')
//                 .add(
//               {
//                 'friendName': userData.data()!['name'],
//                 'uid': userProvider.user.uid,
//                 'profile': userData.data()!['profile'],
//                 'text': '${userData.data()!['name']} starts following you'
//               },
//             );
//           }

//           if (widget.name.isEmpty) {
//             return ListTile(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (ctx) => FriendProfileScreen(
//                           uid: widget.snapshots.data!.docs[index].id,
//                         )));
//               },
//               title: Text(
//                 data['name'],
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 data['email'],
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(data['profile']),
//               ),
//               trailing: FutureBuilder(
//                 future: check(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     alreadyFriend = snapshot.data!;
//                     return OutlinedButton(
//                         onPressed: () {
//                           if (snapshot.data! == 'Message') {
//                             navigate();
//                           } else {
//                             addFriend();
//                           }
//                         },
//                         child: Text(snapshot.data!));
//                   }
//                   return const Text('');
//                 },
//               ),
//             );
//           }
//           if (data['name']
//               .toString()
//               .toLowerCase()
//               .startsWith(widget.name.toLowerCase())) {
//             return ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (ctx) => FriendProfileScreen(
//                       uid: widget.snapshots.data!.docs[index].id,
//                     ),
//                   ),
//                 );
//               },
//               title: Text(
//                 data['name'],
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 data['email'],
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(data['profile']),
//               ),
//               trailing: FutureBuilder(
//                 future: check(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     alreadyFriend = snapshot.data!;
//                     return OutlinedButton(
//                         onPressed: () {
//                           if (snapshot.data! == 'Message') {
//                             navigate();
//                           } else {
//                             addFriend();
//                           }
//                         },
//                         child: Text(snapshot.data!));
//                   }
//                   return const Text('');
//                 },
//               ),
//             );
//           } else {
//             return Container();
//           }
//         });
//   }
// }
