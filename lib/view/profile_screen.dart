import 'package:flutter/material.dart';
import 'package:while_app/resources/components/bottom_options_sheet.dart';
import 'package:while_app/resources/components/bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var color=Colors.blue;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var nh = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: h,
          ),
          Positioned(
              top: nh,
              child: InkWell(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context){
                    return const Bottomsheet();
                  });
                },
                child: Container(height: h / 7, width: w, color: color),
              )),
          Positioned(
              top: nh + h / 7 - w / 8,
              left: w / 12,
              child: InkWell(
                onTap: () {
                   showModalBottomSheet(context: context, builder: (context){
                    return const Bottomsheet();
                  });
                },
                child: CircleAvatar(
                  radius: w / 8,
                ),
              )),
          Positioned(
              top: nh + h / 7 - w / 8 + 3 * nh,
              left: w / 2.5,
              child: const Text(
                "Followers",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 - w / 8 + 3 * nh,
              left: w / 1.5,
              child: const Text(
                "Following",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 - w / 8 + 3 * nh,
              left: w / 1.15,
              child: IconButton(
                  onPressed: () {
                     showModalBottomSheet(context: context, builder: (context){
                    return const MoreOptions();
                  });
                  }, icon: const Icon(Icons.more_vert))),
          Positioned(
              top: nh + h / 7 - w / 8 + 3.8 * nh,
              left: w / 2.5,
              child: const Text(
                "300",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 - w / 8 + 3.8 * nh,
              left: w / 1.5,
              child: const Text(
                "320",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
            top: nh + h / 7 - w / 8 + 5 * nh,
            child: Container(
              padding:const EdgeInsets.only(left: 20, right: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ankit Pandit",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      'My name is Ankit Kumar Dwivedi, I am founder \n'
                      'and CEO of WHILE NETWORKS Private LTD.',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
          // Positioned(
          //   child: Tabs())
        ],
      ),
    );
  }
}
