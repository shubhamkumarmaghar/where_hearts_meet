import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class VideoScreenController extends BaseController {
  late VideoPlayerController playerController;
  late ChewieController chewieController;
  final String videoUrl;
  Widget overlayWidget = Container();

  VideoScreenController({required this.videoUrl});

  @override
  void onInit() {
    setBusy(true);
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      playerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      await playerController.initialize();

      chewieController = ChewieController(
        videoPlayerController: playerController,
        autoPlay: false,
        allowMuting: true,
        zoomAndPan: true,
        looping: true,
        autoInitialize: true,
       // overlay: overlayWidget
      );

      // overlayWidget =chewieController.isPlaying?Container():Container(
      //   width: screenWidth,
      //   height: 200,
      //   decoration: BoxDecoration(image: DecorationImage(image: AssetImage(rashi4,),fit: BoxFit.cover)),
      // );

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
