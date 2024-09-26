import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_e_homies/view_event_details/event_cover/controller/event_cover_controller.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/consts/app_screen_size.dart';

class EventCoverScreen extends StatelessWidget {
  const EventCoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventCoverController>(
        init: EventCoverController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
            ),
            extendBody: true,
            extendBodyBehindAppBar: true,
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
                  decoration: const BoxDecoration(
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
                      heightSpace(screenHeight * 0.05),
                      FittedBox(
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.13,
                          child: Text(
                            ' ${controller.textTitle} ',
                            style: GoogleFonts.dancingScript(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.06,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text(
                          controller.nameText,
                          style: GoogleFonts.moonDance(
                            decoration: TextDecoration.none,
                            color: Colors.pinkAccent.shade200,
                            fontWeight: FontWeight.w800,
                            height: 0.8,
                            fontSize: screenHeight * 0.1,
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
                                image: NetworkImage(controller.eventDetails?.splashBackgroundImage ??
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
                    Get.toNamed(RoutesConst.eventHomeScreen);
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
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
