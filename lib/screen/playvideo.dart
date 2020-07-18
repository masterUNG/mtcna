import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/model/clipvideo_model.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final ClipVideoModel clipVideoModel;
  PlayVideo({Key key, this.clipVideoModel}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  ClipVideoModel clipVideoModel;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clipVideoModel = widget.clipVideoModel;

    print('urlVideo ===>>> ${clipVideoModel.urlPath}');

    videoPlayerController =
        VideoPlayerController.network(clipVideoModel.urlPath);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clipVideoModel == null ? '' : clipVideoModel.nameVideo),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
