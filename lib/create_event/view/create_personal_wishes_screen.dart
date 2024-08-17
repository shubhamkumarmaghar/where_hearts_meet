import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import 'package:where_hearts_meet/utils/widgets/designer_text_field.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
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
              body: Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    createEventHeader(title: 'Happy birthday', image: ''),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    const Text(
                      StringConsts.personalWishesDisclaimer,
                      style: TextStyle(color: Colors.white),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.1,
                          ),
                          Text(
                            'Enter title for Your special personal section',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          DesignerTextField(onChanged: (text) {}, controller: controller.titleController),
                          SizedBox(
                            height: screenHeight * 0.1,
                          ),
                          GestureDetector(
                            onTap: () {
                              showImagePickerDialog(
                                context: Get.context!,
                                onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera),
                                onGallery: () => controller.onCaptureMediaClick(
                                  source: ImageSource.gallery,
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: screenHeight * 0.2,
                              width: screenHeight * 0.2,
                              decoration: controller.backgroundImage != null && controller.backgroundImage!.isNotEmpty
                                  ? BoxDecoration(
                                      border: Border.all(width: 5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(image: NetworkImage(controller.backgroundImage!)))
                                  : BoxDecoration(
                                      border: Border.all(width: 5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(30),
                                      image: const DecorationImage(image: AssetImage(dummyImage), fit: BoxFit.cover),
                                      color: appColor2,
                                    ),
                            ),
                          ),
                        ],
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
