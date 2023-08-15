import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({super.key, required this.videoUrl});
  final Map<String, String> videoUrl;
  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  late VideoPlayerController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl['video']!)
      ..initialize().then((value) {
        _controller.play();
        _controller.setVolume(1);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.black),
      child: VideoPlayer(_controller),
    );
  }
}
