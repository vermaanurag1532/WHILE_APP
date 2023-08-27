import 'package:cloud_firestore/cloud_firestore.dart';



class PostController {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> getPost() {
    return instance
        .collection('Posts')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
