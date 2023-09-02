import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_app/data/model/video_model.dart';

class VideoList {
  // Static method to get the list of video URLs
  static List<Video> getVideoList(QuerySnapshot snapshot) {
    List<Video> videoList = [];
    final List<QueryDocumentSnapshot> documents = snapshot.docs;
    if (documents.isNotEmpty) {
      for (var doc in documents) {
        final List<dynamic> urls = doc['urls'] ?? [];
        if (urls.isNotEmpty) {
          for (var urlData in urls) {
            final String videoUrl = urlData['video'];
            final String title = urlData['title'];
            final String description = urlData['description'];
            videoList.add(Video(
                videoUrl: videoUrl,
                title: title,
                description: description,
                likes: 0));
          }
        }
      }
    }
    return videoList;
  }
}
