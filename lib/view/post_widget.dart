import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final String postUrl;
  const PostWidget({super.key, required this.postUrl});

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
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
                  'Abhishek Bansal',
                  style: GoogleFonts.openSans(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(width: w,child: CachedNetworkImage(imageUrl: postUrl,)),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.heart_broken,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {},
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
            const Row(
              children: [
                SizedBox(width: 10,),
                Text('Abhisehk Bansal'),SizedBox(width: 10,), Text('Caption Catpion',style: TextStyle(fontSize: 15,color: Colors.grey),)],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                InkWell(onTap: () {}, child: const Text("1234 likes")),
                const Spacer(),
                const Text(
                  '10 minutes',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ]),
            )
          ],
        ));
  }
}
