import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class FirebaseAuthMethods{
  final FirebaseAuth _auth;
  FirebaseAuthMethods (this._auth);

  User get user => _auth.currentUser!;

    Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  

   Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
   try{await _auth.createUserWithEmailAndPassword(
        email: email, password: password);}
        on FirebaseAuthException catch(e){
          Utils.snackBar(e.message!, context);
        }}

           Future loginInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
   try{await _auth.signInWithEmailAndPassword(
        email: email, password: password);}
        on FirebaseAuthException catch(e){
          Utils.snackBar(e.message!, context);
        }}

          Future signOut(BuildContext context) async {
    try{await _auth.signOut();}
    on FirebaseAuthException catch(e){
      Utils.snackBar(e.message!, context);
    }
  }
  
}
