import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../controller/video_player_controller.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen({required this.url, super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? playerController;
  ChewieController? chewieController;
  bool isBusy = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (playerController == null || chewieController == null) {
        playerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.url),
        );

        await playerController?.initialize();
        chewieController = ChewieController(
          videoPlayerController: playerController!,
          autoPlay: false,
          allowMuting: true,
          zoomAndPan: true,
          looping: true,
          autoInitialize: true,
        );
        setState(() {
          isBusy = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.3,
      width: screenWidth,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: isBusy
          ? Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primaryColor,
              ),
              child: const Icon(
                Icons.slow_motion_video,
                size: 50,
              ),
            )
          : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Chewie(
              controller: chewieController!,

              // key: UniqueKey(),
            ),
          ),
    );
  }

  @override
  void dispose() {
    playerController?.dispose();
    chewieController?.dispose();
    playerController = null;
    chewieController = null;
    log('dispose called');
    super.dispose();
  }
}
