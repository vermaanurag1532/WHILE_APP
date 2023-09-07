import 'package:flutter/material.dart';
import 'package:while_app/resources/components/message/models/chat_user.dart';
import 'package:while_app/utils/routes/routes_name.dart';

import '../edit_profile_user.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key, required this.user});
  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
              title: const Text("Settings"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RoutesName.settings);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditUserProfileScreen(user: user)));
              },
              leading: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 30,
              ),
              title: const Text("Edit Profile"),
            ),
            const ListTile(
              leading: Icon(
                Icons.download_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: Text("Saved"),
            ),
            const ListTile(
              leading: Icon(
                Icons.share_outlined,
                color: Colors.black,
                size: 30,
              ),
              title: Text("Share"),
            ),
            const ListTile(
              leading: Icon(
                Icons.watch,
                color: Colors.black,
                size: 30,
              ),
              title: Text("Activity"),
            ),
            const ListTile(
              leading: Icon(
                Icons.mobile_friendly,
                color: Colors.black,
                size: 30,
              ),
              title: Text("Refer"),
            ),
            const ListTile(
              leading: Icon(
                Icons.money,
                color: Colors.black,
                size: 30,
              ),
              title: Text("change a plan"),
            )
          ],
        ),
      ),
    );
  }
}
