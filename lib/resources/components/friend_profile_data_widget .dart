import 'package:flutter/material.dart';
import 'bottom_options_sheet.dart';

// ignore: must_be_immutable
class FriendProfileDataWidget extends StatefulWidget {
  FriendProfileDataWidget(
      {super.key, required this.profileImageURl, required this.userName});
  String userName = '';
  String profileImageURl = '';

  @override
  State<FriendProfileDataWidget> createState() =>
      _FriendProfileDataWidgetState();
}

class _FriendProfileDataWidgetState extends State<FriendProfileDataWidget> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var nh = MediaQuery.of(context).viewPadding.top;
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: h / 2.5,
          ),
          Positioned(
              top: nh,
              child: Container(
                height: h / 7,
                width: w,
                color: Colors.grey,
                child: const Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000')),
              )),
          Positioned(
            top: nh + h / 7 - w / 8,
            left: w / 12,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImageURl),
              radius: w / 8,
            ),
          ),
          Positioned(
              top: nh + h / 7 + 5,
              left: w / 2.5,
              child: const Text(
                "Followers",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 + 5,
              left: w / 1.5,
              child: const Text(
                "Following",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7.5,
              left: w / 1.15,
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const MoreOptions();
                        });
                  },
                  icon: const Icon(Icons.more_vert))),
          Positioned(
              top: nh + h / 7 + 24,
              left: w / 2.5,
              child: const Text(
                "300",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: nh + h / 7 + 24,
              left: w / 1.5,
              child: const Text(
                "320",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          Positioned(
            top: nh + h / 7 + w / 8 + 30,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'My name is ${widget.userName} , I am founder \n'
                      'and CEO of WHILE NETWORKS Private LTD.',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
