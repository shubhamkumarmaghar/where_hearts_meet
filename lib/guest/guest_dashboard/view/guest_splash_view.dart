import 'dart:developer';

import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/font_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/routes/app_routes.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/text_styles/custom_text_styles.dart';

import '../../../utils/widgets/swipe_button.dart';
import '../guest_home/controller/guest_home_controller.dart';

class GuestCoverScreen extends StatefulWidget {
  const GuestCoverScreen({super.key});

  @override
  State<GuestCoverScreen> createState() => _GuestCoverScreenState();
}

class _GuestCoverScreenState extends State<GuestCoverScreen> {
  final controller = Get.find<GuestHomeController>();
  String textTitle = '';
  String nameText = '';

  Future<void> textAnimation() async {
    String? text = controller.eventDetails?.eventName;

    List<String>? wordsList = text?.split('');

    for (var word in wordsList!) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        textTitle = textTitle + word;
      });
    }
    nameAnimation();
  }

  void nameAnimation() async {
    String? name = controller.eventDetails?.receiverName;
    List<String>? wordsList = name?.split('');

    for (var word in wordsList!) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        nameText = nameText + word;
      });
    }
  }

  @override
  void initState() {
    getData();
    controller.startCountdown();
    super.initState();
  }

  Future<void> getData() async {
    await controller.getEventDetails('80_Happy Birthday');
    await controller.getEventWishes('80_Happy Birthday');
    await controller.getTimelineWishes('80_Happy Birthday');
    await textAnimation();
    controller.birthday = DateTime.parse(controller.eventDetails?.eventHostDay ?? '2024-10-30 18:30:00.000Z');
  }

  @override
  Widget build(BuildContext context) {
    return controller.isBusy != true
        ? Stack(
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
                    image: DecorationImage(
                      image: NetworkImage(controller.eventDetails?.splashBackgroundImage ??
                          'https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/Black%20Minimalist%20Happy%20Birthday%20Poster%20(1).png?alt=media&token=13bada89-8df2-4c06-b98e-962a08ba929e'),
                      fit: BoxFit.cover,
                    ),
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
                  // Colors.white70,
                  // Colors.white60,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent
                  // Colors.white60,
                  // Colors.white54
                ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    heightSpace(screenHeight * 0.04),
                    FittedBox(
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.13,
                        child: Text(
                          ' $textTitle ',
                          style: GoogleFonts.dancingScript(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: Get.height * 0.06,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      child: Text(
                        nameText,
                        style: GoogleFonts.moonDance(
                          decoration: TextDecoration.none,
                          color: Colors.pinkAccent.shade200,
                          fontWeight: FontWeight.w800,
                          height: 0.8,
                          fontSize: Get.height * 0.1,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    heightSpace(
                      screenHeight * 0.28,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.2,
                      width: screenHeight * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(controller.eventDetails?.splashDisplayImage ??
                                  'https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/Black%20Minimalist%20Happy%20Birthday%20Poster%20(1).png?alt=media&token=13bada89-8df2-4c06-b98e-962a08ba929e'),
                              fit: BoxFit.cover),
                          border: Border.all(width: 5, color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    heightSpace(
                      screenHeight * 0.015,
                    ),
                    Text('Time left',
                        style: GoogleFonts.montserrat(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 30)),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      // color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                          style: GoogleFonts.montserrat(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        ),
                      ),
                    ),
                    Text('Created by: ${controller.eventDetails?.hostName}',
                        style: GoogleFonts.dancingScript(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutesConst.guestDashboard);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 30),
                    child: CircleAvatar(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                        radius: 25),
                    // SwipeButton(child: Text('Welcome'),
                    //   width: screenWidth*0.5,
                    //   enabled: true,
                    //   onSwipeEnd: (){},
                    //   thumbIconColor: Colors.white,
                    //   activeThumbColor: primaryColor,
                    //   inactiveThumbColor: primaryColor,
                    //   activeTrackColor: primaryColor.withOpacity(0.3),
                    //
                    //
                    // ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                Color(0xff9467ff),
                Color(0xffae8bff),
                Color(0xffc7afff),
                Color(0xffdfd2ff),
                Color(0xfff2edff),
              ]),
            ),
            child: Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            )),
          );
  }
}
