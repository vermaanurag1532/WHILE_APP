import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:while_app/data/model/video_model.dart';
import 'package:while_app/resources/components/videoPlayer/circle_animation.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({super.key, required this.video});
  final Video video;
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
    _controller = VideoPlayerController.network(widget.video.videoUrl)
      ..initialize().then((value) {
        _controller.play();
        _controller.setVolume(1);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(children: [
        VideoPlayer(_controller),
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.video.title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            widget.video.description,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.music_note,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(
                                'song name',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(top: size.height / 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildProfile('profilePhoto'),
                        Column(
                          children: [
                            const InkWell(
                                child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              widget.video.likes.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        const Column(
                          children: [
                            InkWell(
                                child: Icon(
                              Icons.comment,
                              color: Colors.white,
                              size: 30,
                            )),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "22 ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        const Column(
                          children: [
                            InkWell(
                                child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 30,
                            )),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "20",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        CircleAnimation(
                            child: buildMusicAlbum('profile photo')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ]),
    );
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image(
                      image: NetworkImage(
                        profilePhoto,
                      ),
                      fit: BoxFit.cover,
                    )),
              ))
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Container(
        padding: const EdgeInsets.all(11),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image(
            image: NetworkImage(profilePhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
