import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../create_event/controller/create_personal_memories_controller.dart';
import '../../player/view/video_player_screen.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/screen_const.dart';
import '../consts/string_consts.dart';
import '../util_functions/decoration_functions.dart';
import 'cached_image.dart';

class MemoryCard extends StatelessWidget {
  final TextEditingController? textController;
  final Function onMediaTap;
  final MediaType? mediaType;
  final String mediaUrl;
  final controller = Get.find<CreatePersonalMemoriesController>();

  MemoryCard({super.key, this.textController, required this.onMediaTap, this.mediaType, required this.mediaUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.68,
      width: screenWidth,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onMediaTap();
            },
            child: mediaUrl.isNotEmpty
                ? mediaType == MediaType.image
                    ? Container(
                        height: screenHeight * 0.68,
                        width: screenWidth,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: cachedImage(imageUrl: mediaUrl),
                        ),
                      )
                    : Container(
                        height: screenHeight * 0.68,
                        width: screenWidth,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FutureBuilder<String?>(
                            future: generateThumbnail(mediaUrl),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  color: Colors.white.withOpacity(0.4),
                                  child: const CupertinoActivityIndicator(
                                    color: primaryColor,
                                    radius: 15.0,
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
                                      width: screenWidth,
                                      child: Image.file(
                                        File(snapshot.data!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => VideoPlayerScreen(url: mediaUrl));
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: primaryColor.withOpacity(0.8), shape: BoxShape.circle),
                                            child: const Icon(
                                              Icons.play_arrow,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text('No data available', style: TextStyle(color: Colors.white));
                              }
                            },
                          ),
                        ),
                      )
                : Container(
                    height: screenHeight * 0.68,
                    width: screenWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: cachedImage(),
                    ),
                  ),
          ),
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.8),
                        Colors.black,
                        Colors.black
                      ])),
                  child: TextField(
                    maxLines: 7,
                    controller: textController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: StringConsts.shareSomethingAboutMemory,
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  )),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Visibility(
              visible: mediaType != null,
              child: GestureDetector(
                onTap: () {
                  if (mediaType != null) {
                    if (mediaType == MediaType.image) {
                      controller.deleteFile(mediaType: MediaType.image, fileUrl: mediaUrl);
                    } else if (mediaType == MediaType.video) {
                      controller.deleteFile(mediaType: MediaType.video, fileUrl: mediaUrl);
                    }
                  }
                },
                child: CircleAvatar(
                  backgroundColor: whiteColor.withOpacity(0.5),
                  child: const Icon(
                    Icons.delete,
                    color: errorColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
