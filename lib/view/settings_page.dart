import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/text_button.dart';
import 'package:while_app/resources/components/text_container_widget.dart';

import '../repository/firebase_repository.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextContainerWidget(
                keyboardType: TextInputType.emailAddress,
                controller: _searchController,
                prefixIcon: Icons.search,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ListTile(
                      leading: Icon(Icons.people_outline),
                      title: Text("Follow and invite friends")),
                  const ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text("Notifications")),
                  const ListTile(
                      leading: Icon(Icons.lock), title: Text("Privacy")),
                  const ListTile(
                      leading: Icon(Icons.people), title: Text("Supervision")),
                  const ListTile(
                      leading: Icon(Icons.security), title: Text("Security")),
                  const ListTile(
                      leading: Icon(Icons.play_arrow),
                      title: Text("Suggested Content")),
                  const ListTile(
                      leading: Icon(Icons.announcement),
                      title: Text("Announcement")),
                  const ListTile(
                      leading: Icon(Icons.account_box), title: Text("Account")),
                  const ListTile(
                      leading: Icon(Icons.help), title: Text("Help")),
                  const ListTile(
                      leading: Icon(Icons.sunny_snowing), title: Text("Theme")),
                  const ListTile(
                    leading: Image(
                      height: 40,
                      image: AssetImage("assets/while.jpg"),
                    ),
                    title: Text("WHILE"),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Textbutton(ontap: () {}, text: "Account Center")),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text("Logins", style: TextStyle(fontSize: 20))),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Textbutton(
                          ontap: () {}, text: "Add or Switch Account")),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Textbutton(ontap: () {
                         FirebaseAuthMethods(FirebaseAuth.instance)
                                .signOut(context);
                                Navigator.of(context).pop();
                      }, text: "Logout"))
                ],
              ),
            )
          ]),
        ));
  }
}
