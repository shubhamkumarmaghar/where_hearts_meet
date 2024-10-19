import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/base_container.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/designer_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/outlined_busy_button.dart';
import '../controller/create_gifts_controller.dart';

class CreateGiftsScreen extends StatelessWidget {
  const CreateGiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateGiftsController>(
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
                          child: _getSubmittedGiftsBadgeView(controller),
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
                                '${StringConsts.selectGiftType}*',
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
                                title:'${StringConsts.senderName}*' ,
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
                                inputType: TextInputType.number,
                                maxLength: 16,
                                onChanged: (text) {},
                                controller: controller.giftCardIdController),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            DesignerTextField(
                                title: StringConsts.giftCardPin,
                                hint: StringConsts.enterGiftCardPin,
                                inputType: TextInputType.number,
                                maxLength: 6,
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
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            _getImagesListWidget(controller),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getImagesListWidget(CreateGiftsController controller) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: screenHeight * 0.03),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.imagesList.length == 5 ? 5 : controller.imagesList.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return controller.imagesList.length == index
              ? GestureDetector(
                  onTap: controller.uploadGiftImage,
                  child: ClayContainer(
                    height: screenHeight * 0.12,
                    borderRadius: 20,
                    color: appColor2,
                    child: Icon(
                      Icons.add_a_photo,
                      size: screenHeight * 0.03,
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
                          child: cachedImage(imageUrl: controller.imagesList[index].fileUrl, boxFit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                          onTap: () => controller.deleteFile(index: index),
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

  Widget _getSubmittedGiftsBadgeView(CreateGiftsController controller) {
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
