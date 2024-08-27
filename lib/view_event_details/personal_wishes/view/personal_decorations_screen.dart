import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/view_event_details/personal_wishes/controller/personal_decorations_controller.dart';
import '../../../player/view/video_player_screen.dart';
import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/string_consts.dart';
import '../../../utils/shimmers/personal_decorations_shimmer.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../../utils/widgets/app_bar_widget.dart';
import '../../../utils/widgets/cached_image.dart';
import '../../../utils/widgets/custom_photo_view.dart';

class PersonalDecorationsScreen extends StatelessWidget {
  const PersonalDecorationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalDecorationsController>(
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            return controller.loadingState.value == LoadingState.loading
                ? const PersonalDecorationsShimmer()
                : controller.loadingState.value == LoadingState.noData
                    ? const EmptyPersonalDecorationsWidget()
                    : BaseContainer(
                        child: Container(
                          height: screenHeight,
                          width: screenWidth,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.07,
                              ),
                              Row(
                                children: [
                                  backIcon(),
                                  const Spacer(),
                                  Text(
                                    StringConsts.personalDecorations,
                                    style: textStyleDangrek(fontSize: 24),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ),
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.03),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: controller.toggleMediaChange,
                                        child: Container(
                                            padding: EdgeInsets.all(screenWidth * 0.03),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              color:
                                                  controller.imagesSelected.value ? Colors.white : Colors.transparent,
                                            ),
                                            child: Text(
                                              StringConsts.images,
                                              style: textStyleMontserrat(
                                                  fontSize: 18,
                                                  color: controller.imagesSelected.value ? primaryColor : Colors.white),
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.06,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: controller.toggleMediaChange,
                                        child: Container(
                                          padding: EdgeInsets.all(screenWidth * 0.03),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: controller.imagesSelected.value ? Colors.transparent : Colors.white,
                                          ),
                                          child: Text(
                                            StringConsts.videos,
                                            style: textStyleMontserrat(
                                                fontSize: 18,
                                                color: controller.imagesSelected.value ? Colors.white : primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              controller.imagesSelected.value
                                  ? _imagesListWidget(imagesList: controller.personalDecorationsModel?.images ?? [])
                                  : _videosListWidget(videosList: controller.personalDecorationsModel?.videos ?? []),
                            ],
                          ),
                        ),
                      );
          }),
        );
      },
    );
  }

  Widget _imagesListWidget({List<String>? imagesList}) {
    if (imagesList == null || imagesList.isEmpty) {
      return Text(
        StringConsts.noImagesFound,
        style: textStyleDangrek(fontSize: 24),
      );
    }
    return Expanded(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: screenHeight * 0.03, top: screenHeight * 0.03),
          itemCount: imagesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1),
          itemBuilder: (BuildContext context, int index) {
            var data = imagesList[index];

            return GestureDetector(
              onTap: () async {
                Get.to(CustomPhotoView(
                  imageUrl: data,
                ));
              },
              child: SizedBox(
                height: screenHeight * 0.3,
                width: screenWidth,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  child: cachedImage(imageUrl: data),
                ),
              ),
            );
          }),
    );
  }

  Widget _videosListWidget({List<String>? videosList}) {
    if (videosList == null || videosList.isEmpty) {
      return Text(
        StringConsts.noVideosFound,
        style: textStyleDangrek(fontSize: 24),
      );
    }
    return Expanded(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: screenHeight * 0.03, top: screenHeight * 0.03),
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  child: FutureBuilder<String?>(
                    future: generateThumbnail(data),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          color: Colors.black.withOpacity(0.2),
                          child: const CupertinoActivityIndicator(
                            color: Colors.white,
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
                            SizedBox(
                              width: screenWidth,
                              child: Image.file(
                                File(snapshot.data!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(color: primaryColor.withOpacity(0.8), shape: BoxShape.circle),
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
          }),
    );
  }
}
