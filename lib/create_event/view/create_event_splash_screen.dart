import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../controller/create_event_controller.dart';
import '../widgets/create_event_widgets.dart';

class CreateEventSplashScreen extends StatelessWidget {
  final controller = Get.find<CreateEventController>();

  CreateEventSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateEventController>(
      builder: (controller) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: controller.createButtonEnabled.value
              ? SliderButton(
                  action: () async {
                    await controller.createEvent();
                    return true;
                  },
                  baseColor: primaryColor,
                  width: screenWidth * 0.8,
                  alignLabel: Alignment.center,
                  height: 60,
                  label: Text(
                    "Slide to create Event",
                    style: textStyleAleo(fontSize: 18, color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.create,
                    color: primaryColor,
                  ),
                )
              : const SizedBox.shrink(),
          appBar: AppBar(
            toolbarHeight: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
          ),
          body: Stack(
            children: [
              Blur(
                blur: 0.1,
                blurColor: Colors.white.withOpacity(0.1),
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: backgroundGradient,
                    image: controller.backgroundImage != null
                        ? DecorationImage(image: NetworkImage(controller.backgroundImage!), fit: BoxFit.cover)
                        : null,
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: whiteGradient,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      heightSpace(screenHeight * 0.08),
                      Text(
                        controller.eventModel.eventName ?? '',
                        maxLines: 2,
                        style: textStyleDancingScript(
                          fontSize: 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        controller.eventModel.receiverName ?? '',
                        maxLines: 2,
                        style: textStyleMoonDance(
                            color: Colors.pinkAccent.shade200, fontWeight: FontWeight.w800, fontSize: 60),
                        textAlign: TextAlign.center,
                      ),
                      heightSpace(
                        screenHeight * 0.12,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.backgroundImage == null || controller.backgroundImage!.isEmpty) {
                            controller.selectImage(EventImageType.backgroundImage);
                          } else {
                            Get.to(() => CustomPhotoView(
                                  imageUrl: controller.backgroundImage,
                                ));
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                                height: screenHeight * 0.2,
                                width: screenHeight * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3, color: Colors.white),
                                  color: appColor2,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: cachedImage(
                                        imageUrl:
                                            controller.backgroundImage != null && controller.backgroundImage!.isNotEmpty
                                                ? controller.backgroundImage!
                                                : null,
                                        boxFit: BoxFit.cover))),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Visibility(
                                visible: controller.backgroundImage != null,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.deleteFile(
                                        imageUrl: controller.backgroundImage!,
                                        imageType: EventImageType.backgroundImage);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: whiteColor.withOpacity(0.5),
                                    child: const Icon(
                                      Icons.delete,
                                      color: errorColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightSpace(
                        screenHeight * 0.06,
                      ),
                      Obx(
                        () {
                          return Visibility(
                            visible: controller.isEventDateSelected.value && controller.isEventTimeSelected.value,
                            replacement: Visibility(
                              visible: controller.isEventDateSelected.value,
                              child: Text(
                                'Event Date : ${getYearTime(controller.selectedDate.toString())} 00:00',
                                style: textStyleDangrek(fontSize: 20, color: primaryColor),
                              ),
                            ),
                            child: timeView(),
                          );
                        },
                      ),
                      heightSpace(
                        screenHeight * 0.03,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: controller.selectDate,
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: appColor3,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    controller.isEventDateSelected.value ? 'Update Date' : 'Add Date',
                                    style:
                                        textStyleAbel(fontSize: 18, color: primaryColor, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: controller.selectTime,
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: appColor3,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    controller.isEventTimeSelected.value ? 'Update Time' : 'Add Time',
                                    style:
                                        textStyleAbel(fontSize: 18, color: primaryColor, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightSpace(
                        screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget timeView() {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      width: screenWidth * 0.86,
      decoration: BoxDecoration(color: appColor3, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: screenHeight * 0.08,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          controller.weekModel?.month != null
                              ? controller.weekModel!.month.toString().substring(0, 3)
                              : '',
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(controller.weekModel?.day ?? '',
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                SizedBox(height: screenHeight * 0.04, child: const VerticalDivider()),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.weekModel?.date ?? '',
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                    Visibility(
                      visible: controller.countdownTimer != null,
                      child: Text(
                          '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                          style: textStyleMontserrat(fontSize: 20)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Gradient get whiteGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.white70,
          Colors.white70,
          Colors.white70,
          Colors.white24,
          Colors.white12,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent
        ],
      );
}
