import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/models/chat_user.dart';
import '../utils/utils.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;
  ChatUser newUser = ChatUser(
    image: 'image',
    about: 'about',
    name: 'name',
    createdAt: 'createdAt',
    isOnline: false,
    id: 'id',
    lastActive: 'lastActive',
    email: 'email',
    pushToken: 'pushToken',
    dateOfBirth: '',
    gender: '',
    phoneNumber: '',
    place: '',
    profession: '',
  );

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future signInWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        newUser.email = email;
        newUser.name = name;
        newUser.about = 'Hey I My name is $name , connect me at $email';
        log('/////as////${_auth.currentUser!.uid}');
        APIs.createNewUser(newUser);
      });
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  Future loginInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  Future<DocumentSnapshot> getSnapshot() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser?.uid)
        .get();
    return snapshot;
  }
}
