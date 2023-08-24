import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/community_user.dart';

late Size mq;

class CommunityProfileDialog extends StatelessWidget {
  const CommunityProfileDialog({super.key, required this.user});

  final CommunityUser user;

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
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                    child: CachedNetworkImage(
                      width: mq.width * .6,
                      fit: BoxFit.fill,
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
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),

                //info button
                Positioned(
                    right: 8,
                    top: 6,
                    child: MaterialButton(
                      onPressed: () {
                        print('pressed///////////////');
                        //for hiding image dialog
                        // Navigator.pop(context);

                        // //move to view profile screen
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => ViewProfileScreen(user: user)));
                      },
                      minWidth: 0,
                      padding: const EdgeInsets.all(0),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.info_outline,
                          color: Colors.blue, size: 30),
                    ))
              ],
            ),
          )),
    );
  }
}
