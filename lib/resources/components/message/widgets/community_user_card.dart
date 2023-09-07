import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../apis.dart';
import '../cdetail.dart';
import '../helper/my_date_util.dart';
import '../models/community_message.dart';
import '../models/community_user.dart';
import 'dialogs/community_profile_dialog.dart';

late Size mq;

//card to represent a single user in home screen
class ChatCommunityCard extends ConsumerStatefulWidget {
  final CommunityUser user;

  const ChatCommunityCard({super.key, required this.user});

  @override
  ConsumerState<ChatCommunityCard> createState() => _ChatCommunityCardState();
}

class _ChatCommunityCardState extends ConsumerState<ChatCommunityCard> {
  //last message info (if null --> no message)
  CommunityMessage? _message;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    log(widget.user.name);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      color: Colors.white,
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            // for navigating to chat screen

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CCommunityDetailScreen(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastCommunityMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list = data
                      ?.map((e) => CommunityMessage.fromJson(e.data()))
                      .toList() ??
                  [];
              if (list.isNotEmpty) {
                _message = list[0];
                log('message ${_message!.msg}');
              }

              return ListTile(
                //user profile picture
                leading: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) =>
                            CommunityProfileDialog(user: widget.user));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * .055,
                      fit: BoxFit.fill,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                ),

                //user name
                title: Text(widget.user.name),

                //last message
                subtitle: Text(
                    _message != null
                        ? _message!.types == Types.image
                            ? 'image'
                            : _message!.msg
                        : widget.user.about,
                    maxLines: 1),

                //last message time
                trailing: _message == null
                    ? null //show nothing when no message is sent
                    : _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
                        ?
                        //show for unread message
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent.shade400,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        :
                        //message sent time
                        Text(
                            MyDateUtil.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.black54),
                          ),
              );
            },
          )),
    );
  }
}
