import 'dart:async';
import 'dart:developer';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import '../../../../utils/consts/confetti_shape_enum.dart';
import '../../../../utils/widgets/confetti_view.dart';
import '../../../../utils/widgets/util_widgets/instagram_post_screen.dart';

import '../../guest_wishlist/view/guest_wishlist.dart';
import '../controller/guest_home_controller.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({super.key});

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> with TickerProviderStateMixin {
  final controller = Get.find<GuestHomeController>();
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
    controller.startCountdown();
    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
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

    secondController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
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

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
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

    fourthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
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
    log('${controller.guestwishesModel.value!.data?[0].senderMessage}');
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Lottie.asset(giftbox,
              height: screenHeight*0.12,
              width: screenHeight*0.12, ),
          ),
          GestureDetector(
            onTap: (){
              log('${controller.guestwishesModel.value.data?[0].senderMessage}');
              istrue.value = istrue.value != true ?true:false;
              controller.update();
            },
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Lottie.network(
                  height: screenHeight*0.14,
                  width: screenHeight*0.14,
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
                Blur(blur: 5,
                  child:
                  Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff9467ff),
                                Color(0xffae8bff),
                                Color(0xffc7afff),
                                Color(0xffdfd2ff),
                                Color(0xfff2edff),
                              ]),
                        ),
                        child: ListView(children: [
                          Stack(
                            children: [
                              Container(
                                height: Get.height * 0.45,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                        NetworkImage(controller.eventDetails?.coverPic??'https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/Black%20Minimalist%20Happy%20Birthday%20Poster%20(1).png?alt=media&token=13bada89-8df2-4c06-b98e-962a08ba929e'),
                                        fit: BoxFit.cover)),
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
                          heightSpace(screenHeight*0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 30),
                                      Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        color: Colors.white,
                                        child: Container(
                                          width: screenWidth*0.4,
                                            padding: EdgeInsets.all(15.0),
                                          child:   Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 40),
                                                Text(
                                                  'TimeLine',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 24,
                                                    color: Color(0xff47455f),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  'About Time Line',
                                                  style: TextStyle(
                                                    // fontFamily: 'Avenir',
                                                    fontSize: 18,
                                                    // color: ,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(height: 26),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Know more',
                                                      style: TextStyle(
                                                        // fontFamily: 'Avenir',
                                                        fontSize: 18,
                                                        //color: secondaryTextColor,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 5,
                                    child: Hero(
                                      tag: 'hello',
                                      child:Lottie.asset(giftbox,
                                        height: screenHeight*0.12,
                                        width: screenHeight*0.12, ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 24,
                                    bottom: 60,
                                    child: Text(
                                      'Earth',
                                      style: TextStyle(
                                        // fontFamily: 'Avenir',
                                        fontSize: 20,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 30),
                                      Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        color: Colors.white,
                                        child: Container(
                                          width: screenWidth*0.4,
                                          padding: EdgeInsets.all(15.0),
                                          child:   Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 40),
                                              Text(
                                                'Personal Wishes',
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: 24,
                                                  color: Color(0xff47455f),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                'About Time Line',
                                                style: TextStyle(
                                                  // fontFamily: 'Avenir',
                                                  fontSize: 18,
                                                  // color: ,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(height: 26),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Know more',
                                                    style: TextStyle(
                                                      // fontFamily: 'Avenir',
                                                      fontSize: 18,
                                                      //color: secondaryTextColor,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 5,
                                    child: Hero(
                                      tag: 'hello',
                                      child: Image.network(height: screenHeight*0.12,width: screenHeight*0.12,
                                          'https://raw.githubusercontent.com/afzalali15/flutter_universe/master/assets/earth.png'),
                                    ),
                                  ),
                                  Positioned(
                                    right: 24,
                                    bottom: 60,
                                    child: Text(
                                      'Earth',
                                      style: TextStyle(
                                        // fontFamily: 'Avenir',
                                        fontSize: 20,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      ),
                  overlay:  istrue.value != true?
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff9467ff),
                            Color(0xffae8bff),
                            Color(0xffc7afff),
                            Color(0xffdfd2ff),
                            Color(0xfff2edff),
                          ]),
                    ),
                    child: ListView(children: [
                      Stack(
                        children: [
                          Container(
                            height: Get.height * 0.45,
                            width: Get.width,
                            decoration:  BoxDecoration(
                                image: DecorationImage(
                                   image: NetworkImage(controller.eventDetails?.coverPic??'https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/Black%20Minimalist%20Happy%20Birthday%20Poster%20(1).png?alt=media&token=13bada89-8df2-4c06-b98e-962a08ba929e'),
                                    fit: BoxFit.cover)),
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
                                     'Time Left', style: GoogleFonts.dancingScript(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.height*0.03,
                                      ),
                                    ),
                                    Text(
                                      '${controller.countdownDuration.inDays}d ${controller.countdownDuration.inHours % 24}h ${controller.countdownDuration.inMinutes % 60}m ${controller.countdownDuration.inSeconds % 60}s',
                                      style: GoogleFonts.dancingScript(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.height*0.03,

                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      heightSpace(screenHeight*0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    color: Colors.white,
                                    child: Container(
                                      width: screenWidth*0.4,
                                      padding: EdgeInsets.all(15.0),
                                      child:   Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 40),
                                          Text(
                                            'TimeLine',
                                            style: TextStyle(
                                              fontFamily: 'Avenir',
                                              fontSize: 24,
                                              color: Color(0xff47455f),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          // Text(
                                          //   'About Time Line',
                                          //   style: TextStyle(
                                          //     // fontFamily: 'Avenir',
                                          //     fontSize: 18,
                                          //     // color: ,
                                          //     fontWeight: FontWeight.w500,
                                          //   ),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          SizedBox(height: 26),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Know more',
                                                style: TextStyle(
                                                  // fontFamily: 'Avenir',
                                                  fontSize: 18,
                                                  //color: secondaryTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                              Positioned(
                                right: 5,
                                child: Hero(
                                  tag: 'hello',
                                  child:Lottie.asset(giftbox,
                                    height: screenHeight*0.12,
                                    width: screenHeight*0.12, ),
                                ),
                              ),
                              // Positioned(
                              //   right: 24,
                              //   bottom: 60,
                              //   child: Text(
                              //     'Earth',
                              //     style: TextStyle(
                              //       // fontFamily: 'Avenir',
                              //       fontSize: 20,
                              //       color: primaryColor,
                              //       fontWeight: FontWeight.w900,
                              //     ),
                              //     textAlign: TextAlign.left,
                              //   ),
                              // ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    color: Colors.white,
                                    child: Container(
                                      width: screenWidth*0.4,
                                      padding: EdgeInsets.all(15.0),
                                      child:   Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 40),
                                          FittedBox(
                                            child: Text(
                                              'Personal Wishes',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 24,
                                                color: Color(0xff47455f),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          // Text(
                                          //   'About Time Line',
                                          //   style: TextStyle(
                                          //     // fontFamily: 'Avenir',
                                          //     fontSize: 18,
                                          //     // color: ,
                                          //     fontWeight: FontWeight.w500,
                                          //   ),
                                          //   textAlign: TextAlign.left,
                                          // ),
                                          SizedBox(height: 26),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Know more',
                                                style: TextStyle(
                                                  // fontFamily: 'Avenir',
                                                  fontSize: 18,
                                                  //color: secondaryTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                              Positioned(
                                right: 5,
                                child: Hero(
                                  tag: 'hello',
                                  child: Image.network(height: screenHeight*0.12,width: screenHeight*0.12,
                                      'https://raw.githubusercontent.com/afzalali15/flutter_universe/master/assets/earth.png'),
                                ),
                              ),
                              // Positioned(
                              //   right: 24,
                              //   bottom: 60,
                              //   child: Text(
                              //     'Earth',
                              //     style: TextStyle(
                              //       // fontFamily: 'Avenir',
                              //       fontSize: 20,
                              //       color: primaryColor,
                              //       fontWeight: FontWeight.w900,
                              //     ),
                              //     textAlign: TextAlign.left,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),

                    ]),
                  ):Container(),
                ),
                istrue.value == true ?
                Positioned(
                  top: Get.height*0.5,
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: Get.height*0.3,
                        minHeight: Get.height*.015
                    ),
                    // height:Get.height*0.55,
                    width: Get.width,
                    child:    CardSwiper(
                      isLoop: true,
                      scale: 0.9,
                      numberOfCardsDisplayed: controller.guestwishesModel.value.data!.length >5 ?5:controller.guestwishesModel.value.data!.length,
                      backCardOffset: const Offset(0,-50,),
                      cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage,
                          int verticalOffsetPercentage) {
                        var data = controller.guestwishesModel.value.data?[index];
                        return
                          GestureDetector(
                            onTap: (){
                              Get.to(GuestWishList());
                            },
                            child: PostWidget(
                              username:data!.senderName??"" ,
                              profileImageUrl:data.senderProfileImage??""  ,
                              likes: 5,
                              //postImageUrl: data.imageUrls??[],
                              caption: data.senderMessage??"",
                            ),
                          );
                      },
                      cardsCount: controller.guestwishesModel.value.data!.length??1),
                  ),
                ):Container(),
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
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
