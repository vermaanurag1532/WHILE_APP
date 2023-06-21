// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/repository/firebase_repository.dart';
import 'package:while_app/resources/components/round_button.dart';
import 'package:while_app/view/social_home_screen.dart';
// import 'package:while_app/view/message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home screen',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const TestScreen()));
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  //To do
                },
                child: Text('Home screen: ${user?.email ?? 'User email'}')),
            const SizedBox(
              height: 10,
            ),
            RoundButton(
                title: 'SignOut',
                onPress: () async {
                  FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
                })
          ],
        ),
      ),
    );
  }
}
