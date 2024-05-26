import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/image_stroy_widget.dart';

import '../../utils/consts/confetti_shape_enum.dart';
import '../../utils/widgets/confetti_view.dart';
import '../../utils/widgets/gradient_text.dart';
import '../controller/event_details_controller.dart';

class EventDetailsScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<EventDetailsController>();

  EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BaseContainer(
        child: Stack(
          children: [
            Container(
              height: _mainHeight,
              width: _mainWidth,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _mainHeight * 0.06,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const CircleAvatar(
                            backgroundColor: appColor1,
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        getEventTitle(event: '${controller.eventDetails.eventName}'),
                        SizedBox(
                          width: _mainHeight * 0.05,
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: _mainHeight * 0.05,
                    ),
                    Container(
                      height: _mainHeight * 0.35,
                      width: _mainWidth ,
                      child:ImageStoryWidget(controller: StoryController(),images: controller.eventDetails.imageList ??[]),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                    Center(
                      child: Text(
                        controller.eventDetails.personName ?? '',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: primaryColor.withOpacity(1)),
                      ),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                    Obx(() {
                      return Text(
                        controller.infoText.value,
                        style: const TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
                      );
                    }),
                  ],
                ),
              ),
            ),
            ConfettiView(
              controller: controller.confettiController,
              confettiShapeEnum: ConfettiShapeEnum.drawHeart,
            ),
          ],
        ),
      ),
    );
  }

  Widget getEventTitle({required String event}) {
    return Center(
      child: GradientText(
        text: event,
        gradient: LinearGradient(
          colors: [
            Colors.red.shade400,
            Colors.blue.shade400,
            const Color(0XFFFF0000),
            const Color(0XFFFF0000),
            Colors.yellow.shade600,
            Colors.red.shade700,
          ],
        ),
        style: TextStyle(
          fontSize: _mainWidth * 0.06,
          fontWeight: FontWeight.w600,
          fontFeatures: const [FontFeature.oldstyleFigures()],
        ),
      ),
    );
  }

  Widget getImageBlock({required String imageUrl, required bool selected}) {
    return Container(
      width: _mainWidth * 0.17,
      height: _mainHeight * 0.08,
      padding: EdgeInsets.all(selected ? 2 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: primaryColor,
      ),
      child: imageUrl.isEmpty
          ? const CircleAvatar(
              child: Icon(
                Icons.person,
                color: primaryColor,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              )),
    );
  }
/* Column(
                          children: [
                            InkWell(onTap: () {
                              controller.selectedImage.value = 1;
                              controller.selectedImageUrl.value = controller.imageUrl1;
                            }, child: Obx(() {
                              return getImageBlock(
                                  imageUrl: controller.imageUrl1, selected: controller.selectedImage.value == 1);
                            })),
                            SizedBox(
                              height: _mainHeight * 0.01,
                            ),
                            InkWell(onTap: () {
                              controller.selectedImage.value = 2;
                              controller.selectedImageUrl.value = controller.imageUrl2;
                            }, child: Obx(() {
                              return getImageBlock(
                                  imageUrl: controller.imageUrl2, selected: controller.selectedImage.value == 2);
                            })),
                            SizedBox(
                              height: _mainHeight * 0.01,
                            ),
                            InkWell(onTap: () {
                              controller.selectedImage.value = 3;
                              controller.selectedImageUrl.value = controller.imageUrl3;
                            }, child: Obx(() {
                              return getImageBlock(
                                  imageUrl: controller.imageUrl3, selected: controller.selectedImage.value == 3);
                            })),
                          ],
                        ),*/
}
