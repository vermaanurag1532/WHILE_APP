import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_app/data/model/video_model.dart';

class VideoList {
  // Static method to get the list of video URLs
  static List<Video> getVideoList(QuerySnapshot snapshot) {
    List<Video> videoList = [];
    // print(snapshot.docs.first.id);
    for (QueryDocumentSnapshot docu in snapshot.docs) {
      // Create a Video object using the data and add it to the list
      Video video = Video(
          videoRef: docu.id,
          uploadedBy: docu.get('uploadedBy'),
          videoUrl: docu.get('videoUrl'),
          title: docu.get('title'),
          description: docu.get('description'),
          likes: docu.get('likes'),
          shares: docu.get('shares'));
      videoList.add(video);
    }
    return videoList;
  }
}
