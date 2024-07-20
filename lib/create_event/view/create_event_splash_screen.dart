import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
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
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Color(0xff9467ff),
                      Color(0xffae8bff),
                      Color(0xffc7afff),
                      Color(0xffdfd2ff),
                      Color(0xfff2edff),
                    ]),
                    image: controller.backgroundImage != null
                        ? DecorationImage(image: NetworkImage(controller.backgroundImage!), fit: BoxFit.cover)
                        : null,
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                  Colors.white,
                  Colors.white70,
                  Colors.white24,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent
                ])),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      heightSpace(screenHeight * 0.08),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20
                        ),
                        //   color: Colors.amber,
                        child: Text(
                          controller.eventModel.eventName ?? 'Add Event Name',
                          style: GoogleFonts.dancingScript(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 60),textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final name =
                              await showTextDialog(dialogTitle: "Person's Name", hintText: "Enter person's Name");
                          controller.eventModel.receiverName = name;
                          controller.update();
                        },
                        child: Container(
                          // color: Colors.red,
                          child: Text(
                            controller.eventModel.receiverName ?? 'Add Name',
                            style: GoogleFonts.moonDance(
                                decoration: TextDecoration.none,
                                color: Colors.pinkAccent.shade200,
                                fontWeight: FontWeight.w800,
                                fontSize: 80),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      heightSpace(
                        screenHeight * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          showImagePickerDialog(
                            context: Get.context!,
                            onCamera: () => controller.onCaptureMediaClick(
                                source: ImageSource.camera, imageType: EventImageType.backgroundImage),
                            onGallery: () => controller.onCaptureMediaClick(
                                source: ImageSource.gallery, imageType: EventImageType.backgroundImage),
                          );
                        },
                        child: Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.7,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            'Tap to upload background image',
                            style: GoogleFonts.dangrek(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      heightSpace(
                        screenHeight * 0.06,
                      ),
                      GestureDetector(
                        onTap: () {
                          showImagePickerDialog(
                            context: Get.context!,
                            onCamera: () => controller.onCaptureMediaClick(
                                source: ImageSource.camera, imageType: EventImageType.displayImage),
                            onGallery: () => controller.onCaptureMediaClick(
                                source: ImageSource.gallery, imageType: EventImageType.displayImage),
                          );
                        },
                        child: controller.displayImage != null && controller.displayImage!.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.2,
                                width: screenHeight * 0.2,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 5, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage(controller.displayImage!))),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: screenHeight * 0.15,
                                width: screenHeight * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 5, color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                    color: appColor2),
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      heightSpace(
                        screenHeight * 0.015,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                  bottom: screenHeight * 0.15, child: Align(alignment: Alignment.bottomCenter, child: timeView())),
              GestureDetector(
                onTap: controller.createEvent,
                // onTap: controller.addWishesEvent,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 30),
                    child: CircleAvatar(
                        radius: 25,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        )),
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
      height: screenHeight * 0.11,
      width: screenWidth * 0.9,
      padding: EdgeInsets.only(left: screenWidth * 0.03),
      decoration: BoxDecoration(color: appColor3, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: screenHeight * 0.08,
            width: screenWidth * 0.7,
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
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(controller.weekModel?.day ?? '',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                SizedBox(height: screenHeight * 0.04, child: VerticalDivider()),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.weekModel?.date ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    Visibility(
                      visible: controller.countdownTimer != null,
                      child: Text(
                        '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                        style: GoogleFonts.montserrat(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            child: GestureDetector(
              onTap: () {
                controller.onSelectDate();
              },
              child: const Icon(
                Icons.edit_calendar_outlined,
                color: Colors.black,
                size: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
