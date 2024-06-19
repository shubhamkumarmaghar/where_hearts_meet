import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';
import 'package:where_hearts_meet/create_event_module/controller/add_event_specials_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/model/dropdown_model.dart';
import 'package:where_hearts_meet/utils/text_styles/custom_text_styles.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';

import '../../utils/buttons/buttons.dart';
import '../../utils/consts/event_special_const.dart';
import '../../utils/util_functions/app_pickers.dart';

class AddWishesScreen extends StatelessWidget {
  const AddWishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEventSpecialsController>(
      builder: (controller) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  const Spacer(),
                  getPrimaryText(text: 'Add Wishes', fontWeight: FontWeight.w700, fontSize: 20),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      controller.onNextScreen(EventSpecialPageIndex.addGiftCards);
                    },
                    child: Container(
                      height: 25,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                      child: getPrimaryText(text: 'Skip', textColor: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPrimaryText(
                      text: 'Add Images', fontWeight: FontWeight.w600, fontSize: 18, textColor: Colors.black),
                  getPrimaryText(
                      text:
                          controller.wishesImagesList.isNotEmpty ? '${controller.wishesImagesList.length}  Images' : '',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      textColor: appColor3),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              SizedBox(height: screenHeight * 0.1, child: getImagesListWidget(controller: controller)),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPrimaryText(
                      text: 'Add Videos', fontWeight: FontWeight.w600, fontSize: 18, textColor: Colors.black),
                  getPrimaryText(
                      text:
                          controller.wishesVideosList.isNotEmpty ? '${controller.wishesVideosList.length}  Videos' : '',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      textColor: appColor3),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              SizedBox(height: screenHeight * 0.1, child: getVideosListWidget(controller: controller)),
              const Spacer(),
              SizedBox(
                width: screenWidth * 0.8,
                child: GradientButton(
                    title: 'Save',
                    enabled: controller.wishesImagesList.isNotEmpty || controller.wishesVideosList.isNotEmpty,
                    onPressed: () {
                      if (controller.wishesImagesList.isEmpty || controller.wishesVideosList.isEmpty) {
                        return;
                      }

                      controller.submitWishes();
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  Widget getImagesListWidget({required AddEventSpecialsController controller}) {
    return RawScrollbar(
      padding: const EdgeInsets.only(bottom: -7),
      radius: const Radius.circular(10),
      thumbColor: appColor4,
      thickness: 3,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.wishesImagesList.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.wishesImagesList.length == index
                  ? getElevatedButton(
                      onPressed: () async {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureImage(
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addWishes),
                          onGallery: () => controller.onCaptureImage(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addWishes),
                        );
                      },
                      child: Icon(
                        Icons.add_photo_alternate,
                        size: screenHeight * 0.05,
                        color: primaryColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureImage(
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addWishes),
                          onGallery: () => controller.onCaptureImage(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addWishes),
                        );
                      },
                      child: SizedBox(
                        width: screenWidth * 0.27,
                        height: screenHeight * 0.1,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: Image.file(
                              controller.wishesImagesList[index],
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
            );
          }),
    );
  }

  Widget getVideosListWidget({required AddEventSpecialsController controller}) {
    return RawScrollbar(
      padding: const EdgeInsets.only(bottom: -7),
      radius: const Radius.circular(10),
      thumbColor: appColor4,
      thickness: 3,
      child: GridView.builder(
          itemCount: controller.wishesVideosList.length + 1,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.wishesVideosList.length == index
                  ? getElevatedButton(
                      onPressed: () async {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureVideo(
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addWishes),
                          onGallery: () => controller.onCaptureVideo(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addWishes),
                        );
                      },
                      child: Icon(
                        UniconsLine.video,
                        size: screenHeight * 0.05,
                        color: primaryColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureVideo(
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addWishes),
                          onGallery: () => controller.onCaptureVideo(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addWishes),
                        );
                      },
                      child: SizedBox(
                        width: screenWidth * 0.27,
                        height: screenHeight * 0.1,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              color: Colors.black,
                            )),
                      ),
                    ),
            );
          }),
    );
  }
}
