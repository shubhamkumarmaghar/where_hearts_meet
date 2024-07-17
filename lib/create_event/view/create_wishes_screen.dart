import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:where_hearts_meet/create_event/controller/create_wishes_controller.dart';

import '../../utils/buttons/buttons.dart';
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
    return GetBuilder<CreateWishesController>(
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
                getElevatedButton(
                  width: screenWidth*0.4,
                  borderRadius: 30,
                  child: Text(
                    'Submit',
                    style: headingStyle(fontSize: 22),
                  ),
                  buttonColor: appColor1,
                  onPressed: controller.addWishes,
                ),
                getOutlinedButton(
                  width: screenWidth*0.4,
                  borderRadius: 30,
                  child: Text(
                    'Next',
                    style: headingStyle(fontSize: 22,color: primaryColor),
                  ),

                  onPressed: controller.navigateToCreateTimelineScreen,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  appHeader,
                  Text(
                    'Add Wishes',
                    style: headingStyle(fontSize: 24),
                  ),
                  Visibility(
                    visible: controller.wishesList.isNotEmpty,
                    replacement: const SizedBox.shrink(),
                    child: SizedBox(
                      height: screenHeight * 0.01,
                    ),
                  ),
                  Visibility(
                    visible: controller.wishesList.isNotEmpty,
                    replacement: const SizedBox.shrink(),
                    child: addWish(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: Container(
                          padding: const EdgeInsets.only(top: 30),
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
                      ),
                      Container(
                        width: screenWidth * 0.7,
                        child: DesignerTextField(
                            title: '',
                            hint: 'Name',
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
                      title: 'Message*',
                      hint: 'Enter message',
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
                      'Upload wishing images*',
                      style: headingStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                      //alignment: Alignment.centerLeft,
                      child: getImagesListWidget()),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload wishing videos*',
                      style: headingStyle(fontSize: 18),
                    ),
                  ),
                  getVideosListWidget()
                ],
              ),
            ),
          ),
        );
      },
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
                        child: Image.network(
                          controller.videosList[index],
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          );
        });
  }

  Widget addWish() {
    return Container(
      height: screenHeight * 0.1,
      //color: Colors.amber,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = controller.wishesList[index];
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      border: Border.all(color: appColor2, width: 1.5)),
                  child: Tooltip(

                    triggerMode: TooltipTriggerMode.tap,
                    margin: EdgeInsets.only(top: 10),
                    richMessage: WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        constraints:  BoxConstraints(maxWidth: screenWidth*0.85),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(60)),
                              child: Image.network(
                                data.senderProfileImage ?? '',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              data.senderMessage ??'',
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    showDuration: Duration(seconds: 30),
                    waitDuration: Duration(seconds: 30),
                    child: Container(
                      width: screenWidth * 0.16,
                      height: screenHeight * 0.07,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(60)),
                        child: Image.network(
                          data.senderProfileImage ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
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
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: controller.wishesList.length),
    );
  }
}
