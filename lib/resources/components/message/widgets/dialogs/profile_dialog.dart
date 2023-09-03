import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/message/models/community_user.dart';
import 'package:while_app/view_model/providers/community_provider.dart';

import '../../models/chat_user.dart';

late Size mq;

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 20),
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
          width: mq.width * .6,
          height: mq.height * .35,
          child: Padding(
            padding: EdgeInsets.only(right: mq.width * .06),
            child: Stack(
              children: [
                //user profile picture
                Positioned(
                  top: mq.height * .075,
                  left: mq.width * .06,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(mq.height * .25),
                    child: CachedNetworkImage(
                      width: mq.width * .6,
                      fit: BoxFit.cover,
                      imageUrl: user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                ),

                //user name
                Positioned(
                  left: mq.width * .06,
                  top: mq.height * .02,
                  width: mq.width * .55,
                  child: Text(user.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ),

                //info button
                Positioned(
                  right: 8,
                  top: 6,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final CommunityUser data = ref.watch(communityProvider);
                      return MaterialButton(
                        onPressed: () {
                          ref.watch(communityProvider.notifier);
                          // for hiding image dialog
                          // Navigator.pop(context);

                          //move to view profile screen
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => ProfileScreen(user: user)));
                        },
                        minWidth: 0,
                        padding: const EdgeInsets.all(0),
                        shape: const CircleBorder(),
                        // child: const Icon(Icons.info_outline,
                        //     color: Colors.blue, size: 30),
                        child: Text(data.name),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
