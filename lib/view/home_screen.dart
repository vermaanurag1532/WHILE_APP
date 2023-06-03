import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/repository/firebase_repository.dart';
import 'package:while_app/resources/components/round_button.dart';

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
