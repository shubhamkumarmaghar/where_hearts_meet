import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:where_hearts_meet/player/view/video_player_screen.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../../utils/util_functions/decoration_functions.dart';

class VideosListScreen extends StatelessWidget {
  final List<String> videosList;

  const VideosListScreen({super.key, required this.videosList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.06,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Text(
                  'Videos',
                  style: textStyleDangrek(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: videosList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  var data = videosList[index];

                  return GestureDetector(
                    onTap: () async {
                      Get.to(VideoPlayerScreen(url: data));
                    },
                    child: SizedBox(
                      height: screenHeight * 0.3,
                      width: screenWidth,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        child: FutureBuilder<String?>(
                          future: generateThumbnail(data),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                color: primaryColor.withOpacity(0.1),

                                // Background color
                                child: const CupertinoActivityIndicator(
                                  color: primaryColor,
                                  radius: 10.0,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.white),
                              );
                            } else if (snapshot.hasData && snapshot.data != null) {
                              return Stack(
                                children: [
                                  Container(

                                    child: Image.file(
                                      File(snapshot.data!),
                                      fit: BoxFit.cover,
                                    ),
                                    width: screenWidth,
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding:const EdgeInsets.all(5 ),
                                        decoration:BoxDecoration(
                                          color: primaryColor.withOpacity(0.8),
                                          shape: BoxShape.circle
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const Text('No data available', style: TextStyle(color: Colors.white));
                            }
                          },
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Future<String?> generateThumbnail(String videoUrl) async {
    final temp = await getTemporaryDirectory();
    String? fileName;
    try {
      fileName = await VideoThumbnail.thumbnailFile(
          video: videoUrl,
          thumbnailPath: temp.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: (screenHeight * 0.6).toInt(),
          quality: 75,
          timeMs: 1);
    } catch (e) {
      log(e.toString());
    }
    return fileName;
  }
}
