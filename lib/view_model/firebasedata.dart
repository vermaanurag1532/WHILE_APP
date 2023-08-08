import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireBaseDataProvider with ChangeNotifier {
  var data;
  // get data => _data;
  Future<QuerySnapshot<Object?>> getData() async {
    data = FirebaseFirestore.instance.collection('Users').snapshots();
    notifyListeners();
    return data;
  }
}
