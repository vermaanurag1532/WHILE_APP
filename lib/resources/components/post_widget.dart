import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:while_app/utils/routes/routes_name.dart';
import 'package:while_app/utils/utils.dart';

class PostWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  const PostWidget({super.key, required this.data});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  Color color = Colors.black;
  String calculateTimeAgo(Timestamp dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime.toDate());

    if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.data['name'],
                  style: GoogleFonts.openSans(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            CachedNetworkImage(
              imageUrl: widget.data['postUrl'],
              width: w,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser!;
                      setState(() {
                        color = Colors.blue;
                      });

                      try {
                        await FirebaseFirestore.instance
                            .collection('Posts')
                            .doc(widget.data['docid'])
                            .collection('likes')
                            .doc(user.uid)
                            .set({
                          'liked': true,
                        });
                      } on FirebaseAuthException catch (e) {
                        Utils.flushBarErrorMessage(e.message!, context);
                      }
                    },
                    icon: Icon(
                      Icons.thumb_up_outlined,
                      color: color,
                    )),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                              height: h / 1.2,
                              width: w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10,),
                                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.grey),height: 5,width: 50),
                                  SizedBox(height: 10,),
                                Text('comments'),
                                SizedBox(height: 20,),
                                Divider(height: 2,color: Colors.grey,),
                                Spacer(),
                                Container(
                                  width: w/1.01,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send))),),
                                ),
                                SizedBox(height: 5,),
                                

                              ],),);
                        },
                      );

                      // final user=FirebaseAuth.instance.currentUser!;
                      // FirebaseFirestore.instance.collection('comments').doc(user.uid).set({
                      //   'comment': '',
                      //   'time': DateTime.now()
                      // });
                    },
                    icon: const Icon(
                      Icons.comment,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_and_archive,
                      color: Colors.black,
                    )),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text('Abhisehk Bansal'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.data['caption'],
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                InkWell(onTap: () {}, child: const Text("1234 likes")),
                const Spacer(),
                Text(
                  calculateTimeAgo(widget.data['time']),
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ]),
            )
          ],
        ));
  }
}
