import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/create_personal_wishes_controller.dart';

class CreatePersonalWishesScreen extends StatelessWidget {
  final controller = Get.find<CreatePersonalWishesController>();

  CreatePersonalWishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GetBuilder<CreatePersonalWishesController>(
          builder: (controller) {
            return Scaffold(
              bottomNavigationBar: Container(
                color: appColor3,
                padding: EdgeInsets.only(
                  bottom: 14,
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: GradientButton(
                  title: 'Submit',
                  width: screenWidth * 0.8,
                  enabled: controller.messagesList.isNotEmpty,
                  onPressed: controller.addPersonalWishes,
                  buttonColor: appColor1,
                  titleTextStyle: textStyleDangrek(fontSize: 22),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    appHeader,
                    Center(
                      child: Text(
                        'Personal Wishes/Messages ',
                        style: textStyleDangrek(fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Wish/Message*',
                                  style: textStyleDangrek(fontSize: 18),
                                ),
                                Visibility(
                                  visible: controller.messagesList.isNotEmpty,
                                  replacement: const SizedBox.shrink(),
                                  child: Text(
                                    '  (${controller.messagesList.length})',
                                    style: textStyleDangrek(fontSize: 18),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: controller.onMessagesTap,
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Add',
                                          style: textStyleDangrek(fontSize: 20, color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Icon(
                                          Icons.add,
                                          color: primaryColor,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            getMessagesListWidget(),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Upload images',
                                style: textStyleDangrek(fontSize: 18),
                              ),
                            ),
                            getImagesListWidget(),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Upload videos',
                                style: textStyleDangrek(fontSize: 18),
                              ),
                            ),
                            getVideosListWidget(),
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

  Widget getMessagesListWidget() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var data = controller.messagesList[index];
        return Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.03),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.message_rounded,
                size: 18,
                color: primaryColor.withOpacity(0.5),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              SizedBox(
                  width: screenWidth * 0.67,
                  child: Text(
                    data,
                  )),
              const Spacer(),
              InkWell(
                onTap: () {
                  controller.messagesList.removeAt(index);
                  controller.update();
                },
                child: const Icon(
                  Icons.delete_forever,
                  color: errorColor,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: screenHeight * 0.01,
      ),
      itemCount: controller.messagesList.length,
    );
  }

  Widget getImagesListWidget() {
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

  Widget getVideosListWidget() {
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
}
