// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:while_app/resources/components/message/models/chat_user.dart';

// class UserNotifier extends StateNotifier<ChatUser> {
//   UserNotifier(super.state);
//   // final user = FirebaseFirestore.instance
//   //     .collection('user')
//   //     .doc(APIs.me.id)
//   //     .get()
//   //     .then((value) =>  value.data()!.map((key, value) => state.));
//   updateUserDetail(ChatUser user) {
//     state = ChatUser(
//         image: user.image,
//         about: user.about,
//         name: user.name,
//         createdAt: user.createdAt,
//         isOnline: user.isOnline,
//         id: user.id,
//         lastActive: user.lastActive,
//         email: user.email,
//         pushToken: user.pushToken);
//   }
// }

// final communityProvider = StateNotifierProvider<UserNotifier, ChatUser>(
//   (ref) {
//     return UserNotifier(ChatUser(
//         image: 'image',
//         about: 'about',
//         name: 'name',
//         createdAt: 'createdAt',
//         isOnline: false,
//         id: 'id',
//         lastActive: 'lastActive',
//         email: 'email',
//         pushToken: 'pushToken'));
//   },
// );
