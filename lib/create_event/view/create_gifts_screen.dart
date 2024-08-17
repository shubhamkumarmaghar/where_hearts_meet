import 'dart:developer';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event/controller/create_gifts_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/designer_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/outlined_busy_button.dart';

class CreateGiftsScreen extends StatelessWidget {
  final controller = Get.find<CreateGiftsController>();

  CreateGiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateGiftsController>(
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
                  title: 'Submit',
                  width: screenWidth * 0.4,
                  onPressed: controller.addGifts,
                  buttonColor: appColor1,
                  titleTextStyle: textStyleDangrek(fontSize: 22),
                ),
                OutlinedBusyButton(
                  title: 'Next',
                  width: screenWidth * 0.4,
                  titleTextStyle: textStyleDangrek(fontSize: 22, color: primaryColor),
                  onPressed: controller.navigateToEventCompletedScreen,
                  enabled: controller.submittedGiftsList.isNotEmpty,
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
                  height: screenHeight * 0.05,
                ),
                appHeader,
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      'E-Gifts',
                      style: textStyleDangrek(fontSize: 24),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: controller.submittedGiftsList.isNotEmpty,
                      replacement: const SizedBox.shrink(),
                      child: _getSubmittedGiftsBadgeView(),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select Gift Type',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        InkWell(
                          onTap: controller.navigateToGiftTypeScreen,
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenWidth,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                            alignment: Alignment.center,
                            child: Text(
                              controller.selectGiftText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: 'Name*',
                            hint: 'Enter sender name',
                            onChanged: (text) {},
                            controller: controller.nameTextController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: 'Gift Title*',
                            hint: 'Enter gift title',
                            enabled: controller.canTitleChange,
                            onChanged: (text) {},
                            controller: controller.giftTitleController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: 'Gift card id',
                            hint: 'Enter gift card id',
                            onChanged: (text) {},
                            controller: controller.giftCardIdController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: 'Gift card pin',
                            hint: 'Enter gift card pin',
                            onChanged: (text) {},
                            controller: controller.giftCardPinController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Upload gift images',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                        ),
                        _getImagesListWidget(),
                      ],
                    ),
                  ),
                )
              ],
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
                        child: Image.network(
                          controller.imagesList[index].fileUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          );
        });
  }

  Widget _getSubmittedGiftsBadgeView() {
    return Stack(
      children: [
        Container(
            height: screenHeight*0.055,
            width: screenHeight*0.055,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  giftsIcon,
                  fit: BoxFit.cover,
                ))),
        Positioned(
          right: 0,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: errorColor,
            child: Text('${controller.submittedGiftsList.length}',style: const TextStyle(color: Colors.white,fontSize: 8),),
          ),
        )
      ],
    );
  }
}