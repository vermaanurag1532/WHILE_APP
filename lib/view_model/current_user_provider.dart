import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider with ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser!;
}
