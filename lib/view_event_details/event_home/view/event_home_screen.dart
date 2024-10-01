import 'dart:async';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_e_homies/view_event_details/event_home/controller/event_home_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/routes_const.dart';
import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/color_const.dart';
import '../../../utils/consts/confetti_shape_enum.dart';
import '../../../utils/text_styles/custom_text_styles.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../../utils/widgets/cached_image.dart';
import '../../../utils/widgets/confetti_view.dart';
import '../../../utils/widgets/util_widgets/instagram_post_screen.dart';
import '../../personal_wishes/view/personal_wishes_cover_screen.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({super.key});

  @override
  State<EventHomeScreen> createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> with TickerProviderStateMixin {
  final controller = Get.find<EventHomeController>();
  RxBool istrue = false.obs;
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();
    //controller.startCountdown();
    firstController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation =
        Tween<double>(begin: 1.9, end: 2.1).animate(CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              firstController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              firstController.forward();
            }
          });

    secondController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    secondAnimation =
        Tween<double>(begin: 1.8, end: 2.4).animate(CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              secondController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              secondController.forward();
            }
          });

    thirdController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation =
        Tween<double>(begin: 1.8, end: 2.4).animate(CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              thirdController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              thirdController.forward();
            }
          });

    fourthController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    fourthAnimation =
        Tween<double>(begin: 1.9, end: 2.1).animate(CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              fourthController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              fourthController.forward();
            }
          });

    Timer(Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    controller.countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !istrue.value,
      onPopInvoked: (didPop) {
        if (istrue.value) {
          istrue.value = !istrue.value;
          controller.update();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                istrue.value = !istrue.value;
                controller.update();
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Lottie.network(
                    height: screenHeight * 0.14,
                    width: screenHeight * 0.14,
                    'https://lottie.host/1b6d706a-c23b-418b-b200-c6c0fa0f77dd/Fcls9Pt6Vo.json'),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: controller.isBusy != true
            ? Stack(
                children: [
                  Blur(
                    blur: 5,
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: backgroundGradient,
                      ),
                      child: ListView(children: [
                        Stack(
                          children: [
                            Container(
                              height: Get.height * 0.45,
                              width: Get.width,
                              child: ClipRRect(
                                child: cachedImage(imageUrl: controller.eventDetails.coverImage),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                child: SizedBox(
                                    width: Get.width,
                                    height: Get.height * 0.3,
                                    child: CustomPaint(
                                      painter: MyPainter(
                                        firstAnimation.value,
                                        secondAnimation.value,
                                        thirdAnimation.value,
                                        fourthAnimation.value,
                                      ),
                                    ))),
                            Positioned(
                                bottom: 10,
                                left: Get.width * 0.23,
                                child: Container(
                                  // height: MediaQuery.of(context).size.height * 0.5,
                                  // color: Colors.black.withOpacity(0.5),
                                  child: Center(
                                    child: Text(
                                      '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        heightSpace(screenHeight * 0.01),
                      ]),
                    ),
                    overlay: istrue.value != true
                        ? Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              gradient: backgroundGradient,
                            ),
                            child: ListView(children: [
                              Stack(
                                children: [
                                  Container(
                                    height: Get.height * 0.75,
                                    width: Get.width,
                                    child: ClipRRect(child: cachedImage(imageUrl: controller.eventDetails.coverImage)),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: SizedBox(
                                          width: Get.width,
                                          height: Get.height * 0.3,
                                          child: CustomPaint(
                                            painter: MyPainter(
                                              firstAnimation.value,
                                              secondAnimation.value,
                                              thirdAnimation.value,
                                              fourthAnimation.value,
                                            ),
                                          ))),
                                  Positioned(
                                      bottom: 10,
                                      // left: Get.width * 0.23,
                                      width: screenWidth,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        // height: MediaQuery.of(context).size.height * 0.5,
                                        // color: Colors.black.withOpacity(0.5),
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.birthday.isAfter(DateTime.now())
                                                  ? 'Time Left'
                                                  : 'Celebrating Now',
                                              style: GoogleFonts.dancingScript(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Get.height * 0.03,
                                              ),
                                            ),
                                            Text(
                                              '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                                              style: GoogleFonts.dancingScript(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Get.height * 0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              heightSpace(screenHeight * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RoutesConst.eGiftsScreen);
                                    },
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(180),
                                      ),
                                      color: Colors.white,
                                      child: CircleAvatar(
                                        radius: 60,
                                        child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.white70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              getPrimaryText(
                                                text: 'E-Gifts',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RoutesConst.wishesScreen);
                                    },
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(180),
                                      ),
                                      color: Colors.white,
                                      child: CircleAvatar(
                                        radius: 60,
                                        child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.white70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              getPrimaryText(
                                                text: 'Wishes',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RoutesConst.personalWishesCoverScreen);
                                    },
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(180),
                                      ),
                                      color: Colors.white,
                                      child: CircleAvatar(
                                        radius: 60,
                                        child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.white70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              FittedBox(
                                                child: getPrimaryText(
                                                  text: 'Personal Wishes',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        : Container(),
                  ),
                  istrue.value == true
                      ? Positioned(
                          top: Get.height * 0.5,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: Get.height * 0.3, minHeight: Get.height * .015),
                            // height:Get.height*0.55,
                            width: Get.width,
                            child: CardSwiper(
                                isLoop: true,
                                scale: 0.9,
                                numberOfCardsDisplayed:
                                    controller.wishesList.length > 5 ? 5 : controller.wishesList.length,
                                backCardOffset: const Offset(
                                  0,
                                  -50,
                                ),
                                cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage,
                                    int verticalOffsetPercentage) {
                                  var data = controller.wishesList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        RoutesConst.wishesScreen,
                                      );
                                    },
                                    child: PostWidget(
                                      username: data!.senderName ?? "",
                                      profileImageUrl: data.senderProfileImage ?? "",
                                      likes: 5,
                                      //postImageUrl: data.imageUrls??[],
                                      caption: data.senderMessage ?? "",
                                    ),
                                  );
                                },
                                cardsCount: controller.wishesList.length ?? 1),
                          ),
                        )
                      : Container(),
                  ConfettiView(
                    controller: controller.homeConfettiController,
                    confettiShapeEnum: ConfettiShapeEnum.drawHeart,
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: primaryColor,
              )),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff3B6ABA).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7, size.height / thirdValue, size.width,
          size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
