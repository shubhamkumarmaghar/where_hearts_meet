import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../controller/video_player_controller.dart';


class VideoPlayerScreen extends StatelessWidget {
  final String url;

  const VideoPlayerScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoScreenController>(
      init: VideoScreenController(videoUrl: url),
      builder: (controller) {
        return Container(
           height: screenHeight*0.3,
          width: screenWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: controller.isBusy
              ? Container(
            height: screenHeight*0.3,
                  width: screenWidth*0.6,
                  color: primaryColor,
                  child: const Icon(
                    Icons.slow_motion_video,
                    size: 50,
                  ),
                )
              : Chewie(
                  controller: controller.chewieController,
                ),
        );
      },
    );
  }
}
