import 'dart:io';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../player/view/video_player_screen.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/designer_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/outlined_busy_button.dart';
import '../controller/create_wishes_controller.dart';

class CreateWishesScreen extends StatelessWidget {
  final controller = Get.find<CreateWishesController>();

  CreateWishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateWishesController>(
      builder: (controller) {
        return PopScope(
          canPop: controller.forEdit,
          child: Scaffold(
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
                    onPressed: controller.addWishes,
                    buttonColor: appColor1,
                    titleTextStyle: textStyleDangrek(fontSize: 22),
                  ),
                  OutlinedBusyButton(
                    title: StringConsts.next,
                    width: screenWidth * 0.4,
                    titleTextStyle: textStyleDangrek(fontSize: 22, color: primaryColor),
                    onPressed: controller.navigateToPersonalWishesScreen,
                    enabled: controller.wishesList.isNotEmpty,
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
              child: Column(
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
                  Text(
                    StringConsts.wishes,
                    style: textStyleDangrek(fontSize: 24),
                  ),
                  Visibility(
                    visible: controller.wishesList.isNotEmpty,
                    replacement: const SizedBox.shrink(),
                    child: SizedBox(
                      height: screenHeight * 0.0,
                    ),
                  ),
                  Visibility(
                    visible: controller.wishesList.isNotEmpty,
                    replacement: const SizedBox.shrink(),
                    child: showWish(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: controller.uploadSenderImage,
                                child: ClayContainer(
                                    width: screenWidth * 0.15,
                                    height: screenHeight * 0.065,
                                    borderRadius: 50,
                                    color: primaryColor,
                                    child: controller.profileImage == null
                                        ? Icon(
                                            Icons.add_a_photo,
                                            size: screenHeight * 0.03,
                                            color: Colors.white,
                                          )
                                        : ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                                            child: cachedImage(
                                                imageUrl: controller.profileImage?.fileUrl, boxFit: BoxFit.cover),
                                          )),
                              ),
                              SizedBox(
                                width: screenWidth * 0.7,
                                child: DesignerTextField(
                                    hint: StringConsts.name,
                                    cornerRadius: 15,
                                    onChanged: (text) {},
                                    controller: controller.nameTextController),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          DesignerTextField(
                              title: '${StringConsts.message}*',
                              hint: StringConsts.enterMessage,
                              maxLines: 6,
                              cornerRadius: 15,
                              onChanged: (text) {},
                              controller: controller.messageTextController),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              StringConsts.uploadWishingImages,
                              style: textStyleDangrek(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          _getImagesListWidget(),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              StringConsts.uploadWishingVideos,
                              style: textStyleDangrek(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          _getVideosListWidget(),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
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
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return controller.imagesList.length == index
              ? GestureDetector(
                  onTap: () => controller.uploadMedia(mediaType: MediaType.image),
                  child: ClayContainer(
                    height: screenHeight * 0.12,
                    borderRadius: 15,
                    color: appColor2,
                    child: Icon(
                      Icons.add_a_photo,
                      size: screenHeight * 0.04,
                      color: Colors.white,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Get.to(() => CustomPhotoView(
                          imageUrl: controller.imagesList[index].fileUrl,
                        ));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.12,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: cachedImage(imageUrl: controller.imagesList[index].fileUrl ?? ''),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                          onTap: () => controller.deleteFile(
                            index: index,
                            mediaType: MediaType.image,
                          ),
                          child: CircleAvatar(
                            radius: 12,
                            child: Icon(
                              Icons.close,
                              size: screenHeight * 0.02,
                              color: errorColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        });
  }

  Widget _getVideosListWidget() {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: screenHeight * 0.03),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.videosList.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: screenWidth * 0.03,
          mainAxisSpacing: screenHeight * 0.02,
        ),
        itemBuilder: (BuildContext context, int index) {
          return controller.videosList.length == index
              ? GestureDetector(
                  onTap: () => controller.uploadMedia(mediaType: MediaType.video),
                  child: ClayContainer(
                    height: screenHeight * 0.12,
                    borderRadius: 15,
                    color: appColor2,
                    child: Icon(
                      Icons.switch_video,
                      size: screenHeight * 0.04,
                      color: Colors.white,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: FutureBuilder<String?>(
                    future: generateThumbnail(controller.videosList[index].fileUrl ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: screenHeight * 0.12,
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
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => VideoPlayerScreen(url: controller.videosList[index].fileUrl ?? ''));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: screenHeight * 0.14,
                                width: screenWidth,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
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
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () => controller.deleteFile(
                                    index: index,
                                    mediaType: MediaType.video,
                                  ),
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: Icon(
                                      Icons.close,
                                      size: screenHeight * 0.02,
                                      color: errorColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return const Text('No data available', style: TextStyle(color: Colors.white));
                      }
                    },
                  ),
                );
        });
  }

  Widget showWish() {
    return SizedBox(
      height: screenHeight * 0.1,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = controller.wishesList[index];

            return GestureDetector(
              onTap: () {
                controller.navigateToCreatedWishesPreviewScreen(data);
              },
              child: Column(
                children: [
                  Container(
                    width: screenHeight * 0.07,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(60)),
                        border: Border.all(color: appColor2, width: 1.5)),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      child: Image.network(
                        data.senderProfileImage ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    data.senderName != null && data.senderName!.isNotEmpty
                        ? data.senderName.toString().capitalizeFirst.toString()
                        : '',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: controller.wishesList.length),
    );
  }
}
