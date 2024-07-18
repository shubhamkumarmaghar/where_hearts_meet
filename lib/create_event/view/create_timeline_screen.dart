import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/widgets/circular_dotted_border.dart';

import '../../utils/buttons/buttons.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';

import '../../utils/widgets/image_stroy_widget.dart';
import '../controller/create_timeline_controller.dart';

class CreateTimelineScreen extends StatelessWidget {
  final controller = Get.find<CreateTimelineController>();

  CreateTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTimelineController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: Container(
            color: appColor3,
            padding: EdgeInsets.only(
              bottom: 14,
              left: screenWidth * 0.06,
              right: screenWidth * 0.06,
            ),
            child: getElevatedButton(
              width: screenWidth * 0.4,
              borderRadius: 30,
              child: Text(
                'Submit',
                style: headingStyle(fontSize: 22),
              ),
              buttonColor: appColor1,
              onPressed: controller.addTimelineStories,
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
                    height: screenHeight * 0.05,
                  ),
                  appHeader,
                  Center(
                    child: Text(
                      'Add Timeline Stories',
                      style: headingStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: controller.imagesList.isNotEmpty,
                        replacement: const SizedBox.shrink(),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ImageStoryWidget(
                                      images: controller.imagesList.map((e) => e.fileUrl ?? '').toList(),
                                    ));
                              },
                              child: DottedCircularBorder(
                                totalNumber: controller.imagesList.length,
                                dotsColor: Colors.white,
                                widget: Container(
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.22,
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: controller.imagesList.isNotEmpty
                                        ? Image.network(
                                            controller.imagesList.first.fileUrl ?? '',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(dummyImage),
                                  ),
                                ),
                                radius: screenWidth * 0.1,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            const Text(
                              'Photos',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Visibility(
                        visible: controller.videosList.isNotEmpty,
                        replacement: const SizedBox.shrink(),
                        child: Column(
                          children: [
                            DottedCircularBorder(
                              totalNumber: controller.videosList.length,
                              dotsColor: Colors.white,
                              widget: Container(
                                height: screenHeight * 0.12,
                                width: screenWidth * 0.22,
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              radius: screenWidth * 0.1,
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            const Text(
                              'Videos',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: controller.imagesList.isNotEmpty || controller.videosList.isNotEmpty,
                    child: SizedBox(
                      height: screenHeight * 0.03,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload timeline images*',
                      style: headingStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  addTimelineImages(),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload timeline videos*',
                      style: headingStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  addTimelineVideos(),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget addTimelineImages() {
    return GestureDetector(
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
          color: appColor1,
          child: Icon(
            Icons.add_a_photo,
            size: screenHeight * 0.03,
            color: Colors.white,
          )),
    );
  }

  Widget addTimelineVideos() {
    return GestureDetector(
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
          color: appColor1,
          child: Icon(
            Icons.switch_video,
            size: screenHeight * 0.03,
            color: Colors.white,
          )),
    );
  }
}
