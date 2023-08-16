// import 'package:flutter/material.dart';
// import 'package:while_app/data/model/community.dart';
// import 'package:while_app/view/social/community_detail.dart';

// class CommunityList extends StatelessWidget {
//   const CommunityList({super.key, required this.message});
//   final List<CommunityDetail> message;
//   @override
//   Widget build(BuildContext context) {
//     void addChatUserDialog() {
//       // ignore: unused_local_variable
//       String email;

//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           contentPadding:
//               const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),

//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

//           //title
//           title: const Row(
//             children: [
//               Icon(
//                 Icons.person_add,
//                 color: Colors.red,
//                 size: 28,
//               ),
//               Text('Add Community')
//             ],
//           ),

//           //content
//           content: Column(
//             children: [
//               TextFormField(
//                 maxLines: null,
//                 onChanged: (value) => email = value,
//                 decoration: InputDecoration(
//                     hintText: 'Community Name',
//                     prefixIcon: const Icon(Icons.email, color: Colors.blue),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15))),
//               ),
//               TextFormField(
//                 maxLines: null,
//                 onChanged: (value) => email = value,
//                 decoration: InputDecoration(
//                     hintText: '',
//                     prefixIcon: const Icon(Icons.email, color: Colors.blue),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15))),
//               ),
//             ],
//           ),

//           //actions
//           actions: [
//             //cancel button
//             MaterialButton(
//                 onPressed: () {
//                   //hide alert dialog
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Cancel',
//                     style: TextStyle(color: Colors.red, fontSize: 16))),

//             //add button
//             MaterialButton(
//                 onPressed: () async {
//                   //hide alert dialog
//                   // Navigator.pop(context);
//                   // if (email.isNotEmpty) {
//                   //   await APIs.addChatUser(email).then((value) {
//                   //     if (!value) {
//                   //       Dialogs.showSnackbar(context, 'User does not Exists!');
//                   //     }
//                   //   });
//                   // }
//                 },
//                 child: const Text(
//                   'Add',
//                   style: TextStyle(color: Colors.blue, fontSize: 16),
//                 ))
//           ],
//         ),
//       );
//     }

//     if (message.isEmpty) {
//       return Center(
//         child: Text(
//           'No Message is added yet',
//           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                 color: Theme.of(context).colorScheme.onBackground,
//               ),
//         ),
//       );
//     }
//     return Scaffold(
//       body: Stack(
//         alignment: AlignmentDirectional.bottomEnd,
//         children: [
//           ListView.builder(
//               itemCount: message.length,
//               itemBuilder: (ctx, index) => ListTile(
//                     leading: CircleAvatar(
//                       radius: 56,
//                       backgroundImage: NetworkImage(message[index].image),
//                     ),
//                     title: Text(
//                       message[index].title,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (ctx) => CommunityDetailScreen(
//                           userName: message[index].title,
//                           userImage: message[index].image,
//                           id: '',
//                         ),
//                       ));
//                     },
//                     contentPadding: const EdgeInsets.only(top: 15, left: 2),
//                   )),
//           Container(
//             margin: const EdgeInsets.only(right: 20, bottom: 40),
//             child: FloatingActionButton.extended(
//               onPressed: () {
//                 addChatUserDialog();
//               },
//               label: const Icon(
//                 Icons.group_add,
//                 size: 30,
//               ),
//               // extendedPadding: EdgeInsets.o(30),
//               elevation: 10,
//               splashColor: Colors.purple,
//               extendedPadding: const EdgeInsets.only(
//                 top: 20,
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//               ),
//               backgroundColor: Colors.deepPurpleAccent,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
