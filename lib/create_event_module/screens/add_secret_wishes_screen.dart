import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../utils/buttons/buttons.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/event_special_const.dart';
import '../../utils/text_styles/custom_text_styles.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_event_specials_controller.dart';

class AddSecretWishesScreen extends StatelessWidget {
  const AddSecretWishesScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.onPreviousScreen(EventSpecialPageIndex.addGiftCards);
                    },
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  getPrimaryText(text: 'Add Secret Wishes', fontWeight: FontWeight.w700, fontSize: 20),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Container(
                width: screenWidth * 0.8,
                child: CustomTextField(
                    title: 'Secret message',
                    hint: 'Enter Secret message',
                    onChanged: (text) {},
                    controller: controller.secretWishesMessageController),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPrimaryText(
                      text: 'Add Images', fontWeight: FontWeight.w600, fontSize: 18, textColor: Colors.black),
                  getPrimaryText(
                      text: controller.secretWishesImagesList.isNotEmpty
                          ? '${controller.secretWishesImagesList.length}  Images'
                          : '',
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
                      text: controller.secretWishesVideosList.isNotEmpty
                          ? '${controller.secretWishesVideosList.length}  Videos'
                          : '',
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
                    title: 'Submit',
                    enabled:
                        controller.secretWishesImagesList.isNotEmpty || controller.secretWishesVideosList.isNotEmpty,
                    onPressed: () {
                      if (controller.secretWishesImagesList.isEmpty || controller.secretWishesVideosList.isEmpty) {
                        return;
                      }

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
          itemCount: controller.secretWishesImagesList.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.secretWishesImagesList.length == index
                  ? getElevatedButton(
                      onPressed: () async {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureImage(
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addTimeline),
                          onGallery: () => controller.onCaptureImage(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addTimeline),
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
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addTimeline),
                          onGallery: () => controller.onCaptureImage(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addTimeline),
                        );
                      },
                      child: SizedBox(
                        width: screenWidth * 0.27,
                        height: screenHeight * 0.1,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: Image.network(
                              controller.secretWishesImagesList[index],
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
          itemCount: controller.secretWishesVideosList.length + 1,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.secretWishesVideosList.length == index
                  ? getElevatedButton(
                      onPressed: () async {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureVideo(
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addTimeline),
                          onGallery: () => controller.onCaptureVideo(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addTimeline),
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
                              source: ImageSource.camera, pageIndex: EventSpecialPageIndex.addTimeline),
                          onGallery: () => controller.onCaptureVideo(
                              source: ImageSource.gallery, pageIndex: EventSpecialPageIndex.addTimeline),
                        );
                      },
                      child: SizedBox(
                        width: screenWidth * 0.27,
                        height: screenHeight * 0.1,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            child: Image.network(
                              controller.secretWishesImagesList[index],
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
            );
          }),
    );
  }
}
