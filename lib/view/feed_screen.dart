import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:while_app/theme/pallete.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin:const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: currentTheme.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            SizedBox(
              height: h / 3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.feeds);
                    },
                    child: Container(
                      height: h / 3,
                      width: w / 1.1,
                      decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20,)),color: Colors.blue),
                      margin:const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: (w-w/1.1)/2,),
                Text('Trending', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 5,),
            Container(
              padding:const EdgeInsets.only(left: 10),
              height: h / 7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: h / 3,
                    width: w / 2.5,
                    decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20,)),color: Colors.blue),
                    margin:const EdgeInsets.only(left: 10),
                  );
                },
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: (w-w/1.1)/2,),
                Text('Trending', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 5,),
            Container(
              padding:const EdgeInsets.only(left: 10),
              height: h / 7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: h / 3,
                    width: w / 2.5,
                    decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20,)),color: Colors.blue),
                    margin:const EdgeInsets.only(left: 10),
                  );
                },
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: (w-w/1.1)/2,),
                Text('Trending', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: h / 7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: h / 3,
                    width: w / 2.5,
                    decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20,)),color: Colors.blue),
                    margin:const EdgeInsets.only(left: 10),
                  );
                },
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: (w-w/1.1)/2,),
                Text('Trending', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: h / 7,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: h / 3,
                    width: w / 2.5,
                    decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20,)),color: Colors.blue),
                    margin:const EdgeInsets.only(left: 10),
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ));
  }
}
