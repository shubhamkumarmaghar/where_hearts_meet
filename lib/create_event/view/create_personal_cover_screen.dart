import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../controller/create_personal_cover_controller.dart';

class CreatePersonalCoverScreen extends StatelessWidget {
  final controller = Get.find<CreatePersonalCoverController>();

  CreatePersonalCoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GetBuilder<CreatePersonalCoverController>(
          builder: (controller) {
            return Scaffold(
              body: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      primaryColor.withOpacity(0.2),
                      primaryColor.withOpacity(0.5),
                      primaryColor.withOpacity(0.8),
                      primaryColor,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        height: screenHeight * 0.6,
                        width: screenWidth,
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        decoration: controller.backgroundImage != null &&
                                controller.backgroundImage!.fileUrl != null &&
                                controller.backgroundImage!.fileUrl!.isNotEmpty
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: NetworkImage(controller.backgroundImage!.fileUrl!), fit: BoxFit.fitHeight))
                            : BoxDecoration(
                                border: const Border(bottom: BorderSide(color: primaryColor, width: 5)),
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(image: AssetImage(dummyImage), fit: BoxFit.cover),
                              ),
                        child: GestureDetector(
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
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Upload',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: screenHeight * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.1,
                            ),
                            SizedBox(
                              width: screenWidth,
                              child: Row(
                                children: [
                                  Spacer(),
                                  GestureDetector(
                                    onTap: controller.titleController.text.isEmpty ? controller.onMessagesTap : () {},
                                    child: Container(
                                      width: screenWidth * 0.7,
                                      padding: controller.titleController.text.isEmpty
                                          ? EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                                          : null,
                                      alignment: Alignment.center,
                                      decoration: controller.titleController.text.isEmpty
                                          ? BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10))
                                          : null,
                                      child: Text(
                                        controller.titleController.text.isEmpty
                                            ? 'Title for Your special personal section'
                                            : controller.titleController.text,
                                        style: textStyleDangrek(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  controller.titleController.text.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.titleController.text.isNotEmpty
                                                ? controller.onMessagesTap()
                                                : () {};
                                          },
                                          child: Container(
                                            height: 40,
                                            width: screenWidth * 0.1,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: appColor1,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 20,
                      //left: screenWidth*0.4,
                      child: GestureDetector(
                        onTap: controller.addPersonalWishesCover,
                        child: ClayContainer(
                          color: primaryColor.withOpacity(0.8),
                          borderRadius: 10,
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'Start ',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 15,
                      left: 15,
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: cachedImage(
                                          imageUrl:
                                          controller.eventResponseModel.coverImage ??''))),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Container(
                                width: screenWidth * 0.55,
                                child:  Text(
                                  controller.eventResponseModel.eventName ??'',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primaryColor),
                                ),
                              ),
                              Spacer(),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle, color: primaryColor.withOpacity(0.8)),
                                  child: Icon(
                                    Icons.question_mark_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: screenWidth * 0.04,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
