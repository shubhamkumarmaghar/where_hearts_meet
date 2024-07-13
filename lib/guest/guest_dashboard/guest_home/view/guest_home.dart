import 'dart:async';

import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:motion/motion.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

import '../../../../utils/consts/confetti_shape_enum.dart';
import '../../../../utils/dialogs/pop_up_dialogs.dart';
import '../../../../utils/widgets/confetti_view.dart';
import '../../../../utils/widgets/util_widgets/instagram_post_screen.dart';
import '../controller/guest_home_controller.dart';
import '../model/temp_guest_receive.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({super.key});

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> with TickerProviderStateMixin {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
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
        vsync: this, duration: Duration(milliseconds: 1500));
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
        vsync: this, duration: Duration(milliseconds: 1500));
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
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: GestureDetector(
          onTap: (){
            istrue.value = istrue.value != true ?true:false;
            controller.update();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
                backgroundColor: Colors.red.withOpacity(0.3),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 24,
                )),
          ),
        ),
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
                                height: Get.height * 0.5,
                                width: Get.width,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(rashi2),
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
                                                'Wishes',
                                                style: TextStyle(
                                                 // fontFamily: 'Avenir',
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
                                                'Gift Box',
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
                          )
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
                            height: Get.height * 0.5,
                            width: Get.width,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(rashi2),
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
                                            'Wishes',
                                            style: TextStyle(
                                              // fontFamily: 'Avenir',
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
                                            'Gift Box',
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
                      )
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
                      numberOfCardsDisplayed: 5,
                      backCardOffset: Offset(0,-50,),

                      cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage,
                          int verticalOffsetPercentage) {
                        return
                          PostWidget(
                            username:characters[index].title.toString() ,
                            profileImageUrl:characters[index].avatar.toString()  ,
                            likes: 5,
                            postImageUrl: characters[index].avatar.toString(),
                            caption: characters[index].description.toString(),
                          );
                        //   Container(
                        //   width: Get.width*0.7,
                        //   height: Get.height*35,
                        //   padding: const EdgeInsets.all(8.0),
                        //   margin: EdgeInsets.all(10),
                        //   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
                        //   child: Column(
                        //     children: [
                        //       // Profile section
                        //       Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           CircleAvatar(
                        //             radius: 20,
                        //             backgroundImage: AssetImage(characters[index].avatar??sun1),
                        //           ),
                        //           SizedBox(width: 10),
                        //           Expanded(
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Row(
                        //                   children: [
                        //                     Text(
                        //                       characters[index].title.toString(),
                        //                       style: TextStyle(fontWeight: FontWeight.bold),
                        //                     ),
                        //                     SizedBox(width: 5),
                        //                     Text(
                        //                       ' ',
                        //                       style: TextStyle(color: Colors.grey),
                        //                     ),
                        //                     Spacer(),
                        //                     Icon(Icons.more_vert),
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 5),
                        //                 Text(
                        //                   characters[index].description.toString(),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(height: 10),
                        //       // Action buttons
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //         children: [
                        //           Icon(Icons.chat_bubble_outline),
                        //           Icon(Icons.repeat),
                        //           Icon(Icons.favorite_border),
                        //           Icon(Icons.share),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                      cardsCount: characters.length,),
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
