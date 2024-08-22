import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:where_hearts_meet/player/view/video_player_screen.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';

import '../consts/app_screen_size.dart';
import '../consts/string_consts.dart';
import 'cached_image.dart';

class MemoryCard extends StatelessWidget {
  final TextEditingController? textController;
  final Function onMediaTap;
  final String? text;
  final MediaType? mediaType;
  final String mediaUrl;
  final bool isEditable;

  const MemoryCard(
      {super.key,
      this.textController,
      this.text,
      required this.onMediaTap,
      this.mediaType,
      this.isEditable = true,
      required this.mediaUrl});

  @override
  Widget build(BuildContext context) {
    log('media $mediaUrl -$mediaType');
    if (textController != null && text != null) {
      throw AssertionError('Text Controller & Text can be provided at same time.');
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.68,
            width: screenWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isEditable) {
                      onMediaTap();
                    }
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
                                child: VideoPlayerScreen(
                                  url: mediaUrl,
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
                      child: isEditable
                          ? Scrollbar(
                              thickness: 4,
                              radius: const Radius.circular(10),
                              child: TextField(
                                maxLines: 7,
                                controller: textController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: StringConsts.shareSomethingAboutMemory,
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Scrollbar(
                                thickness: 4,
                                radius: const Radius.circular(10),
                                scrollbarOrientation: ScrollbarOrientation.right,
                                child: SingleChildScrollView(
                                  child: Text(text ?? "", style: const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          )
        ],
      ),
    );
  }
}
