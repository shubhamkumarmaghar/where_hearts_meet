import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/event_module/controller/event_details_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';

import '../../utils/consts/confetti_shape_enum.dart';
import '../../utils/widgets/confetti_view.dart';
import '../../utils/widgets/gradient_text.dart';

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
                      height: _mainHeight * 0.1,
                    ),
                    getEventTitle(event: '${controller.eventDetails.eventName} ${controller.eventDetails.name}'),
                    SizedBox(
                      height: _mainHeight * 0.05,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: _mainHeight * 0.25,
                          width: _mainWidth * 0.7,
                          child: Card(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                child: Obx(() {
                                  return Image.network(
                                    controller.selectedImageUrl.value,
                                    fit: BoxFit.cover,
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Column(
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(onTap: () {
                          controller.selectedImage.value = 4;
                          controller.selectedImageUrl.value = controller.imageUrl4;
                        }, child: Obx(() {
                          return getImageBlock(
                              imageUrl: controller.imageUrl4, selected: controller.selectedImage.value == 4);
                        })),
                        InkWell(onTap: () {
                          controller.selectedImage.value = 5;
                          controller.selectedImageUrl.value = controller.imageUrl5;
                        }, child: Obx(() {
                          return getImageBlock(
                              imageUrl: controller.imageUrl5, selected: controller.selectedImage.value == 5);
                        })),
                        InkWell(onTap: () {
                          controller.selectedImage.value = 6;
                          controller.selectedImageUrl.value = controller.imageUrl6;
                        }, child: Obx(() {
                          return getImageBlock(
                              imageUrl: controller.imageUrl6, selected: controller.selectedImage.value == 6);
                        })),
                        InkWell(onTap: () {
                          controller.selectedImage.value = 6;
                          controller.selectedImageUrl.value = controller.imageUrl6;
                        }, child: Obx(() {
                          return getImageBlock(
                              imageUrl: controller.imageUrl6, selected: controller.selectedImage.value == 6);
                        })),
                      ],
                    ),
                    SizedBox(
                      height: _mainHeight * 0.05,
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
    return GradientText(
      text: event,
      gradient: LinearGradient(
        colors: [
          Colors.red.shade400,
          Colors.blue.shade400,
          Color(0XFFFF0000),
          Color(0XFFFF0000),
          Colors.yellow.shade600,
          Colors.red.shade700,
        ],
      ),
      style: TextStyle(
        fontSize: _mainWidth * 0.06,
        fontWeight: FontWeight.w600,
        fontFeatures: [FontFeature.oldstyleFigures()],
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
}
