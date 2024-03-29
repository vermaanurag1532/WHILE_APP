import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/community_detail_opportunities_widget.dart';
import 'package:while_app/resources/components/community_detail_quiz_widget.dart';
import 'package:while_app/resources/components/community_detail_resources_widget%20.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/profile_screen.dart';
import 'package:while_app/resources/components/message/widgets/profileCommunity.dart';

import 'cchat.dart';
import 'models/community_user.dart';

late Size mq;

class CCommunityDetailScreen extends StatefulWidget {
  const CCommunityDetailScreen({Key? key, required this.user})
      : super(key: key);
  final CommunityUser user;
  @override
  State<CCommunityDetailScreen> createState() => _CCommunityDetailScreenState();
}

class _CCommunityDetailScreenState extends State<CCommunityDetailScreen> {
  /// List of Tab Bar Item

  List<String> itemsName = const [
    'Chat',
    'Resources',
    'Opportunites',
    'Quiz',
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    log('height ${mq.height}');
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    log(keyboardSpace.toString());
    List items = [
      CChatScreen(
        user: widget.user,
      ),
      const CommunityDetailResources(),
      const CommunityDetailOpportunities(),
      const CommunityDetailQuiz(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: GestureDetector(
          onTap: () {
            if (widget.user.email == APIs.me.email) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(user: widget.user)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ProfileScreenParticipant(user: widget.user)));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: 42,
                  height: 42,
                  imageUrl: widget.user.image,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.image, size: 70),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(widget.user.name),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          /// CUSTOM TABBAR
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(top: 10, left: 12),
                          width: itemsName[index].length.toDouble() * 4 + 60,
                          height: 45,
                          decoration: BoxDecoration(
                            color: current == index
                                ? Colors.white70
                                : Colors.white54,
                            borderRadius: current == index
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(10),
                            border: current == index
                                ? Border.all(
                                    color: Colors.deepPurpleAccent, width: 2)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              itemsName[index],
                              // style: GoogleFonts.laila(
                              //     fontWeight: FontWeight.w500,
                              //     color: current == index
                              //         ? Colors.black
                              //         : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: current == index,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                shape: BoxShape.circle),
                          ))
                    ],
                  );
                }),
          ),

          /// MAIN BODY

          SingleChildScrollView(
            child: SizedBox(
              height: mq.height - keyboardSpace - mq.height / 5.2,
              child: items[current],
            ),
          ),
        ],
      ),
    );
  }
}
