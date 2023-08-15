import 'package:cloud_firestore/cloud_firestore.dart';

class VideoList{
  // Static method to get the list of video URLs
  static List<Map<String, String>> getVideoList(QuerySnapshot snapshot) {
    List<Map<String, String>> videoList = [];
    final List<QueryDocumentSnapshot> documents = snapshot.docs;
    for (var doc in documents) {
      final List<dynamic> urls = doc['urls'];
      if (urls.isNotEmpty) {
        for (var urlData in urls) {
          final String videoUrl = urlData['video'];
          final String title = urlData['title'];
          final String description = urlData['description'];
          videoList.add({
            'video': videoUrl,
            'title': title,
            'description': description,
          });
        }
      }
    }
    return videoList;
  }
}
