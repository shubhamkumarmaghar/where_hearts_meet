import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../utils/controller/base_controller.dart';

class VideoScreenController extends BaseController {
  late VideoPlayerController playerController;
  late ChewieController chewieController;
  final String videoUrl;

  VideoScreenController({required this.videoUrl});

  @override
  void onInit() {
    setBusy(true);
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      playerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl),);

      await playerController.initialize();

      chewieController = ChewieController(
        videoPlayerController: playerController,
        autoPlay: false,
        allowMuting: true,
        zoomAndPan: true,
        looping: true,
        autoInitialize: true,

      );
      setBusy(false);
      update();
    });
  }

  @override
  void onClose() {

    playerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}
