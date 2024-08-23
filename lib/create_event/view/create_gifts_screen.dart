import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event/controller/create_gifts_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';

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
    return PopScope(
        canPop: false,
        child: GetBuilder<CreateGiftsController>(
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
                      onPressed: controller.addGifts,
                      buttonColor: appColor1,
                      titleTextStyle: textStyleDangrek(fontSize: 22),
                    ),
                    Obx(() {
                      return OutlinedBusyButton(
                        title: controller.nextButtonTitle.value,
                        width: screenWidth * 0.4,
                        titleTextStyle: textStyleDangrek(fontSize: 22, color: primaryColor),
                        onPressed: controller.navigateToEventCompletedScreen,
                        enabled: true,
                      );
                    })
                  ],
                ),
              ),
              body: BaseContainer(
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
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
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            StringConsts.eGifts,
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
                                  StringConsts.selectGiftType,
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
                                  decoration:
                                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
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
                                  title: StringConsts.senderName,
                                  hint: StringConsts.enterSenderName,
                                  onChanged: (text) {},
                                  controller: controller.nameTextController),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              DesignerTextField(
                                  title: '${StringConsts.giftTitle}*',
                                  hint: StringConsts.enterGiftTitle,
                                  enabled: controller.canTitleChange,
                                  onChanged: (text) {},
                                  controller: controller.giftTitleController),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              DesignerTextField(
                                  title: StringConsts.giftCardId,
                                  hint: StringConsts.enterGiftCardId,
                                  onChanged: (text) {},
                                  controller: controller.giftCardIdController),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              DesignerTextField(
                                  title: StringConsts.giftCardPin,
                                  hint: StringConsts.enterGiftCardPin,
                                  onChanged: (text) {},
                                  controller: controller.giftCardPinController),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${StringConsts.uploadGiftImages} (Max 3)',
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
        //itemCount: controller.imagesList.length == 3 ? 3 : controller.imagesList.length + 1,
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
                borderRadius: 20,
                color: appColor2,
                child: controller.imagesList.length == index
                    ? Icon(
                        Icons.add_a_photo,
                        size: screenHeight * 0.03,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: cachedImage(imageUrl: controller.imagesList[index].fileUrl, boxFit: BoxFit.cover),
                      ),
              ),
            ),
          );
        });
  }

  Widget _getSubmittedGiftsBadgeView() {
    return GestureDetector(
      onTap: controller.navigateToGiftPreviewScreen,
      child: Stack(
        children: [
          Container(
              height: screenHeight * 0.055,
              width: screenHeight * 0.055,
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
              child: Text(
                '${controller.submittedGiftsList.length}',
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
