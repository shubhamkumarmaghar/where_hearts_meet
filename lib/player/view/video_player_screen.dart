import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../controller/video_player_controller.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final BorderRadius? borderRadius;

  const VideoPlayerScreen({required this.url, super.key,this.borderRadius});

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
          looping: true,allowPlaybackSpeedChanging: false,
          materialProgressColors: ChewieProgressColors(bufferedColor: Colors.white.withOpacity(0.4),playedColor: primaryColor),
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
          ? videoShimmer()
          : ClipRRect(
              borderRadius:widget.borderRadius ?? BorderRadius.circular(20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Chewie(
                controller: chewieController!,


                // key: UniqueKey(),
              ),
            ),
    );
  }

  Widget videoShimmer() {
    return Shimmer.fromColors(
      baseColor: primaryColor.withOpacity(0.25),
      highlightColor: primaryColor.withOpacity(0.4),
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.slow_motion_video,
          size: 50,
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
