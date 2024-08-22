import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/personal_memories_model.dart';
import 'package:where_hearts_meet/player/view/video_player_screen.dart';
import 'package:where_hearts_meet/preview_event/controller/created_memories_preview_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import 'package:where_hearts_meet/utils/widgets/line_indicator.dart';
import 'package:where_hearts_meet/utils/widgets/memory_card.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/widgets/custom_photo_view.dart';

class CreatedMemoriesPreviewScreen extends StatelessWidget {
  const CreatedMemoriesPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatedMemoriesPreviewController>(
      builder: (controller) {
        return Scaffold(
          body: BaseContainer(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.07,
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
                      const Spacer(),
                      Text(
                        'Memories',
                        style: textStyleDangrek(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
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
                          top: screenHeight * 0.015,
                          left: screenWidth * 0.04,
                          right: screenWidth * 0.04,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Obx(() {
                              return LineIndicator(
                                  totalCount: controller.memoriesList.length, currentIndex: controller.pageIndex.value);
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget memoriesView(PersonalMemoriesModel data) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                border: Border.all(color: Colors.white, width: 0.2)),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: data.fileType == 'video'
                  ? VideoPlayerScreen(
                      url: data.file ?? '',
                    )
                  : GestureDetector(
                      onTap: () async {
                        Get.to(() => CustomPhotoView(
                              imageUrl: data.file,
                            ));
                      },
                      child: cachedImage(imageUrl: data.file)),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  height: screenHeight * 0.25,
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                    Colors.black
                  ],

                      ), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                  ),
                  child: Scrollbar(
                    thickness: 4,
                    radius: const Radius.circular(10),
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: SingleChildScrollView(
                      child: Text(
                         data.description ?? '',
                        //StringConsts.dummyText + StringConsts.dummyText,
                        style: textStyleAleo(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
      ],
    );
  }
}
