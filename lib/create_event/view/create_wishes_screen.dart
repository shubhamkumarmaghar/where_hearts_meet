import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:where_hearts_meet/create_event/controller/create_wishes_controller.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';
import 'package:where_hearts_meet/utils/widgets/outlined_busy_button.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/designer_text_field.dart';

class CreateWishesScreen extends StatelessWidget {
  final controller = Get.find<CreateWishesController>();

  CreateWishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GetBuilder<CreateWishesController>(
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
                            SizedBox(height: screenHeight*0.015,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showImagePickerDialog(
                                      context: Get.context!,
                                      onCamera: () =>
                                          controller.onCaptureMediaClick(source: ImageSource.camera, forProfile: true),
                                      onGallery: () =>
                                          controller.onCaptureMediaClick(source: ImageSource.gallery, forProfile: true),
                                    );
                                  },
                                  child: ClayContainer(
                                      width: screenWidth * 0.15,
                                      height: screenHeight * 0.065,
                                      borderRadius: 50,
                                      color: appColor1,
                                      child: controller.profileImage == null
                                          ? Icon(
                                              Icons.add_a_photo,
                                              size: screenHeight * 0.03,
                                              color: Colors.white,
                                            )
                                          : ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                                              child: Image.network(
                                                controller.profileImage?.fileUrl ?? '',
                                                fit: BoxFit.cover,
                                              ),
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
                            _getImagesListWidget(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                StringConsts.uploadWishingVideos,
                                style: textStyleDangrek(fontSize: 18),
                              ),
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
              onTap: () {
                showImagePickerDialog(
                  context: Get.context!,
                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera),
                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery),
                );
              },
              child: ClayContainer(
                width: screenWidth * 0.18,
                height: screenHeight * 0.08,
                borderRadius: 15,
                color: appColor2,
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
              onTap: () {
                showImagePickerDialog(
                  context: Get.context!,
                  onCamera: () => controller.onCaptureVideo(source: ImageSource.camera),
                  onGallery: () => controller.onCaptureVideo(source: ImageSource.gallery),
                );
              },
              child: ClayContainer(
                width: screenWidth * 0.18,
                height: screenHeight * 0.08,
                borderRadius: 15,
                color: appColor2,
                child: controller.videosList.length == index
                    ? Icon(
                        Icons.switch_video,
                        size: screenHeight * 0.03,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: cachedImage(imageUrl: controller.videosList[index].fileUrl ?? ''),
                      ),
              ),
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
