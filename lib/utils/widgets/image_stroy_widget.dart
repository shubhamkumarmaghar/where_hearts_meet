import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

class ImageStoryWidget extends StatelessWidget {
  final StoryController controller;
  final List<String> images;
  int currentIndex = 0;

  ImageStoryWidget({
    super.key,
    required this.controller,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Icon(Icons.image);
    }
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: StoryView(
            onStoryShow: (value) {
              String key = value.view.key.toString();
              final keyIndex = key.substring(key.indexOf("'") + 1, key.lastIndexOf("'"));
              currentIndex = int.parse(keyIndex);
            },
            storyItems: [
              for (int i = 0; i < images.length; i++)
                StoryItem.pageProviderImage(
                  key: Key('$i'),
                  NetworkImage(images[i]),
                  imageFit: BoxFit.contain,
                  duration: const Duration(seconds: 5),
                )
            ],
            repeat: true,
            inline: true,
            progressPosition: ProgressPosition.bottom,
            controller: controller,
            indicatorColor: images.length == 1 ? Colors.transparent : primaryColor,
            indicatorForegroundColor: images.length == 1 ? Colors.transparent : Colors.white,
          ),
        ),
        if (images.length != 1)
          Positioned(
              top: screenHeight * 0.16,
              left: screenWidth * 0.03,
              child: GestureDetector(
                onTap: () => controller.previous(),
                child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: primaryColor,
                      size: 14,
                    )),
              )),
        if (images.length != 1)
          Positioned(
              top: screenHeight * 0.16,
              right: screenWidth * 0.03,
              child: InkWell(
                onTap: () => controller.next(),
                child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: primaryColor,
                      size: 14,
                    )),
              )),
        Positioned(
            top: screenHeight * 0.015,
            right: screenWidth * 0.03,
            child: InkWell(
              onTap: () {},
              child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.fullscreen,
                    color: primaryColor,
                    size: 16,
                  )),
            )),
      ],
    );
  }
}
