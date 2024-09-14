import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import '../../create_event/model/personal_memories_model.dart';
import '../../player/view/video_player_screen.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/line_indicator.dart';
import '../controller/created_memories_preview_controller.dart';

class CreatedMemoriesPreviewScreen extends StatelessWidget {
  const CreatedMemoriesPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatedMemoriesPreviewController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // SizedBox(
                //   height: screenHeight * 0.07,
                // ),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Get.back();
                //       },
                //       child: const Icon(
                //         Icons.arrow_back_ios_new,
                //         color: Colors.white,
                //         size: 18,
                //       ),
                //     ),
                //     const Spacer(),
                //     Text(
                //       'Memories',
                //       style: textStyleDangrek(),
                //     ),
                //     const Spacer(),
                //   ],
                // ),
                // SizedBox(
                //   height: screenHeight * 0.03,
                // ),
                Expanded(
                  child: Stack(
                    children: [
                      PageView.builder(
                          itemCount: controller.memoriesList.length,
                          onPageChanged: controller.onPageChanged,
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller.memoriesList[index];
                            return memoriesView(data);
                          }),
                      Positioned.fill(
                        top: screenHeight * 0.06,
                        left: screenWidth * 0.04,
                        right: screenWidth * 0.04,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Obx(() {
                            return LineIndicator(
                                height: 2,
                                totalCount: controller.memoriesList.length,
                                currentIndex: controller.pageIndex.value);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget memoriesView(PersonalMemoriesModel data) {
    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight * 0.8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            border: data.fileType == 'video' ? Border.all(color: Colors.white, width: 0.2) : null,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: data.fileType == 'video'
                ? VideoPlayerScreen(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  url: data.file ?? '',
                )
                : GestureDetector(
                    onTap: () async {
                      Get.to(() => CustomPhotoView(
                            imageUrl: data.file,
                          ));
                    },
                    child: cachedImage(imageUrl: data.file, boxFit: BoxFit.cover)),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
              height: screenHeight * 0.3,
              width: screenWidth,
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                ]),
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              ),
              child: Scrollbar(
                thickness: 4,
                radius: const Radius.circular(10),
                scrollbarOrientation: ScrollbarOrientation.right,
                child: SingleChildScrollView(
                  child: Text(
                    data.description ?? '',
                    style: textStyleAleo(fontSize: 16, color: Colors.white),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
