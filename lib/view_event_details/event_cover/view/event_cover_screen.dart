import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_e_homies/view_event_details/event_cover/controller/event_cover_controller.dart';
import 'package:slider_button/slider_button.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/color_const.dart';
import '../../../utils/util_functions/decoration_functions.dart';

class EventCoverScreen extends StatelessWidget {
  const EventCoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventCoverController>(builder: (controller) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SliderButton(
          action: () async {
            Get.toNamed(RoutesConst.eventHomeScreen);
            return false;
          },
          baseColor: Colors.white,
          highlightedColor: Colors.grey,
          backgroundColor: primaryColor,
          width: screenWidth * 0.8,
          alignLabel: Alignment.center,
          height: 60,
          label: Text(
            "Slide to view Event",
            style: textStyleAleo(fontSize: 18, color: Colors.white),
          ),
          icon: const Icon(
            Icons.arrow_forward,
            color: primaryColor,
          ),
          child: Container(
            height: 50,
            width: 40,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(
              Icons.arrow_forward,
              color: primaryColor,
              size: 20,
            ),
          ),
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
                  image: DecorationImage(
                    image: NetworkImage(controller.eventDetails.splashBackgroundImage ??
                        'https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/Black%20Minimalist%20Happy%20Birthday%20Poster%20(1).png?alt=media&token=13bada89-8df2-4c06-b98e-962a08ba929e'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(gradient: whiteGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  heightSpace(screenHeight * 0.05),
                  FittedBox(
                    child: Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        controller.textTitle,
                        style: textStyleDancingScript(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight * 0.06,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.nameText,
                      style: textStyleDancingScript(
                        color: Colors.pinkAccent.shade200,
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.08,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    height: screenHeight * 0.2,
                    width: screenHeight * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(controller.eventDetails.splashBackgroundImage ??
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
                  Center(
                    child: Text(
                      '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                      style: GoogleFonts.montserrat(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),
                  Text('Created by: ${controller.eventDetails.hostName}',
                      style: GoogleFonts.dancingScript(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
