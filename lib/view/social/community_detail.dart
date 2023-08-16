import 'package:flutter/material.dart';
import 'package:while_app/resources/components/communities/communities_chat.dart';
import 'package:while_app/resources/components/community_detail_opportunities_widget.dart';
import 'package:while_app/resources/components/community_detail_quiz_widget.dart';
import 'package:while_app/resources/components/community_detail_resources_widget%20.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen(
      {Key? key,
      required this.userImage,
      required this.userName,
      required this.id})
      : super(key: key);
  final String userName;
  final String userImage;
  final String id;
  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
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
    List items = [
      CommunitiesChatScreen(
        id: widget.id,
      ),
      const CommunityDetailResources(),
      const CommunityDetailOpportunities(),
      const CommunityDetailQuiz(),
    ];
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 20,
              minRadius: 2,
              backgroundImage: NetworkImage(widget.userImage, scale: 0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(widget.userName),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Column(
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
                      return Column(
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
                              width:
                                  itemsName[index].length.toDouble() * 4 + 60,
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
                                        color: Colors.deepPurpleAccent,
                                        width: 2)
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
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 175,
                child: items[current],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
