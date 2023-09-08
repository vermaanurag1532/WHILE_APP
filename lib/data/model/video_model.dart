// ignore_for_file: public_member_api_docs, sort_constructors_first
class Video{
  final String videoRef; // the one who will like the video
  final String uploadedBy;// user id ofd the one who made the upload
  final String videoUrl;
  final String title;
  final String description;
  final List likes; // better as a list rather than a counter
  final int shares;
  Video({
    required this.videoRef,
    required this.uploadedBy,
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.likes,
    required this.shares,
  });
}
