import 'dart:io';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/outlined_busy_button.dart';
import '../controller/create_personal_decorations_controller.dart';

class CreatePersonalDecorationsScreen extends StatelessWidget {
  final controller = Get.find<CreatePersonalDecorationsController>();

  CreatePersonalDecorationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GetBuilder<CreatePersonalDecorationsController>(
          builder: (controller) {
            return Scaffold(
              bottomNavigationBar: Container(
                color: appColor3,
                padding: EdgeInsets.only(
                  bottom: 14,
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientButton(
                      title: StringConsts.submit,
                      width: screenWidth * 0.4,
                      onPressed: controller.addPersonalDecoration,
                      buttonColor: appColor1,
                      enabled: controller.imagesList.isNotEmpty || controller.videosList.isNotEmpty,
                      titleTextStyle: textStyleDangrek(fontSize: 22),
                    ),
                    OutlinedBusyButton(
                      title: StringConsts.skip,
                      width: screenWidth * 0.4,
                      titleTextStyle: textStyleDangrek(fontSize: 22, color: primaryColor),
                      onPressed: controller.navigateToCreateGiftScreen,
                    ),
                  ],
                ),
              ),
              body: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(gradient: backgroundGradient),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.06,
                      ),
                      eventHeaderView(
                          text: controller.eventResponseModel.eventName ?? '',
                          image: controller.eventResponseModel.coverImage),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Center(
                        child: Text(
                          'Images/Videos For ${controller.eventResponseModel.receiverName ?? ''}',
                          textAlign: TextAlign.center,
                          style: textStyleDangrek(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upload images*',
                          style: textStyleDangrek(fontSize: 18),
                        ),
                      ),
                      _getImagesListWidget(),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upload videos*',
                          style: textStyleDangrek(fontSize: 18),
                        ),
                      ),
                      _getVideosListWidget(),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget _getImagesListWidget() {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.imagesList.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => controller.uploadMedia(MediaType.image),
              child: ClayContainer(
                width: screenWidth * 0.18,
                height: screenHeight * 0.08,
                borderRadius: 15,
                color: appColor1,
                child: controller.imagesList.length == index
                    ? Icon(
                        Icons.add_a_photo,
                        size: screenHeight * 0.03,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: cachedImage(imageUrl: controller.imagesList[index].fileUrl ?? ''),
                      ),
              ),
            ),
          );
        });
  }

  Widget _getVideosListWidget() {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.videosList.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => controller.uploadMedia(MediaType.video),
              child: ClayContainer(
                width: screenWidth * 0.18,
                height: screenHeight * 0.08,
                borderRadius: 15,
                color: appColor1,
                child: controller.videosList.length == index
                    ? Icon(
                        Icons.switch_video,
                        size: screenHeight * 0.03,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        child: FutureBuilder<String?>(
                          future: generateThumbnail(controller.videosList[index].fileUrl ?? ""),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                color: Colors.white.withOpacity(0.4),
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
                                          size: 15,
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
            ),
          );
        });
  }
}
