import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import 'custom_photo_view.dart';

class ImageStoryWidget extends StatelessWidget {
  final StoryController controller = StoryController();
  final List<String>? images;
  int currentIndex = 0;

  ImageStoryWidget({
    super.key,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return const Icon(Icons.image);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: ()=>Get.back(),
            child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20,)),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            StoryView(
              onStoryShow: (value,index) {
                String key = value.view.key.toString();
                final keyIndex = key.substring(key.indexOf("'") + 1, key.lastIndexOf("'"));
                currentIndex = int.parse(keyIndex);
              },
              storyItems: [
                for (int i = 0; i < images!.length; i++)
                  StoryItem.pageProviderImage(
                    key: Key('$i'),
                    NetworkImage(images![i]),
                    imageFit: BoxFit.contain,
                    duration: const Duration(seconds: 5),
                  )
              ],
              repeat: true,
              inline: true,
              progressPosition: ProgressPosition.top,
              controller: controller,
              indicatorColor: images?.length == 1 ? Colors.transparent : primaryColor,
              indicatorForegroundColor: images?.length == 1 ? Colors.transparent : Colors.white,
            ),
            // if (images?.length != 1)
            //   Positioned(
            //       top: screenHeight * 0.16,
            //       left: screenWidth * 0.03,
            //       child: GestureDetector(
            //         onTap: () => controller.previous(),
            //         child: const CircleAvatar(
            //             radius: 14,
            //             backgroundColor: Colors.white,
            //             child: Icon(
            //               Icons.arrow_back_ios_new,
            //               color: primaryColor,
            //               size: 14,
            //             )),
            //       )),
            // if (images!.length != 1)
            //   Positioned(
            //       top: screenHeight * 0.16,
            //       right: screenWidth * 0.03,
            //       child: InkWell(
            //         onTap: () => controller.next(),
            //         child: const CircleAvatar(
            //             radius: 14,
            //             backgroundColor: Colors.white,
            //             child: Icon(
            //               Icons.arrow_forward_ios,
            //               color: primaryColor,
            //               size: 14,
            //             )),
            //       )),
            Positioned(
                bottom: screenHeight * 0.1,
                right: screenWidth * 0.03,
                child: InkWell(
                  onTap: () {
                    Get.to(() => CustomPhotoView(
                          imageUrl: images?[currentIndex],
                        ));
                  },
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
        ),
      ),
    );
  }
}
