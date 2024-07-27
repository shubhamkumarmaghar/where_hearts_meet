import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/buttons/buttons.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/event_special_const.dart';
import '../../utils/text_styles/custom_text_styles.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_event_specials_controller.dart';

class AddTimelineScreen extends StatelessWidget {
  const AddTimelineScreen({super.key});

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
                  getPrimaryText(text: 'Add Timeline', fontWeight: FontWeight.w700, fontSize: 20),
                  GestureDetector(
                    onTap: () {
                       controller.onNextScreen(EventSpecialPageIndex.addSecretWishes);
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
                      text: controller.timelineImagesList.isNotEmpty
                          ? '${controller.timelineImagesList.length}  Images'
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
                      text: controller.timelineVideosList.isNotEmpty
                          ? '${controller.timelineVideosList.length}  Videos'
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
                    title: 'Save',
                    enabled: controller.timelineImagesList.isNotEmpty || controller.timelineVideosList.isNotEmpty,
                    onPressed: () {
                      if (controller.timelineImagesList.isEmpty || controller.timelineVideosList.isEmpty) {
                        return;
                      }
                      controller.onNextScreen(EventSpecialPageIndex.addGiftCards);
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
          itemCount: controller.timelineImagesList.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.timelineImagesList.length == index
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
                              controller.timelineImagesList[index],
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
          itemCount: controller.timelineVideosList.length + 1,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.timelineVideosList.length == index
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
                        Icons.video_collection,
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
                              controller.timelineImagesList[index],
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
            );
          }),
    );
  }
}
