// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Video {
  final String uploadedBy;
  final String videoUrl;
  final String title;
  final String description;
  final int likes;
  final int shares;
  Video({
    required this.uploadedBy,
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.likes,
    required this.shares,
  });

  Video copyWith({
    String? uploadedBy,
    String? videoUrl,
    String? title,
    String? description,
    int? likes,
    int? shares,
  }) {
    return Video(
      uploadedBy: uploadedBy ?? this.uploadedBy,
      videoUrl: videoUrl ?? this.videoUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uploadedBy': uploadedBy,
      'videoUrl': videoUrl,
      'title': title,
      'description': description,
      'likes': likes,
      'shares': shares,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      uploadedBy: map['uploadedBy'] as String,
      videoUrl: map['videoUrl'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      likes: map['likes'] as int,
      shares: map['shares'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Video(uploadedBy: $uploadedBy, videoUrl: $videoUrl, title: $title, description: $description, likes: $likes, shares: $shares)';
  }

  @override
  bool operator ==(covariant Video other) {
    if (identical(this, other)) return true;
  
    return 
      other.uploadedBy == uploadedBy &&
      other.videoUrl == videoUrl &&
      other.title == title &&
      other.description == description &&
      other.likes == likes &&
      other.shares == shares;
  }

  @override
  int get hashCode {
    return uploadedBy.hashCode ^
      videoUrl.hashCode ^
      title.hashCode ^
      description.hashCode ^
      likes.hashCode ^
      shares.hashCode;
  }
}
