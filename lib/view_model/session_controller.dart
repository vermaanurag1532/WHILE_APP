import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSessionController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid {
    return _auth.currentUser?.uid;
  }

  bool get isSignedIn {
    return _auth.currentUser != null;
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
