import 'dart:ui';

import 'package:chewie/src/chewie_player.dart';
import 'package:chewie/src/cupertino_controls.dart';
import 'package:chewie/src/material_controls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerWithControls extends StatelessWidget {
  PlayerWithControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = ChewieController.of(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
//      child: AspectRatio(
//        aspectRatio:
//        chewieController.aspectRatio ?? _calculateAspectRatio(context),
//        child: _buildPlayerWithControls(chewieController, context),
//      ),
      child: _buildPlayerWithControls(chewieController, context),
    );
  }

  Widget _buildPlayerWithControls(
      ChewieController chewieController, BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: chewieController.placeholder ?? Container(),
        ),
        Align(
          alignment: Alignment.center,
          child: Hero(
            tag: chewieController.videoPlayerController,
            child: AspectRatio(
              aspectRatio: chewieController.aspectRatio ??
                  _calculateAspectRatio(context),
              child: VideoPlayer(chewieController.videoPlayerController),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: chewieController.overlay ?? Container(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildControls(context, chewieController),
        ),
      ],
    );
  }

  Widget _buildControls(
    BuildContext context,
    ChewieController chewieController,
  ) {
    return chewieController.showControls
        ? chewieController.customControls != null
            ? chewieController.customControls
            : Theme.of(context).platform == TargetPlatform.android
                ? MaterialControls()
                : CupertinoControls(
                    backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
                    iconColor: Color.fromARGB(255, 200, 200, 200),
                  )
        : Container();
  }

  double _calculateAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return width > height ? width / height : height / width;
  }
}
