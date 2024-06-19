import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:motion/motion.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

import '../../../utils/consts/confetti_shape_enum.dart';
import '../../../utils/widgets/confetti_view.dart';
import '../controller/guest_home_controller.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({super.key});

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;
  GuestHomeController controller = Get.find();

  @override
  void initState() {
    super.initState();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                            image: AssetImage(
                              sun1,
                            ),
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
                    child: TimerCountdown(
                      format: CountDownTimerFormat.daysHoursMinutesSeconds,
                      endTime: DateTime.now().add(
                        Duration(
                          days: 5,
                          hours: 14,
                          minutes: 27,
                          seconds: 33,
                        ),
                      ),
                      spacerWidth: 1,
                      descriptionTextStyle:
                          TextStyle(color: Colors.white, fontSize: 16),
                      timeTextStyle:
                          TextStyle(color: Colors.white, fontSize: 30),
                      colonsTextStyle:TextStyle(color: Colors.white, fontSize: 30) ,
                      secondsDescription: 'Sec',
                      minutesDescription: 'Min',
                    ),
                  ),
                ],
              ),
              Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Motion.elevated(
                  elevation: 300,
                  //shadow: false,

                  translation: true,

                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    width: 280,
                    height: 170,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                            image: AssetImage(
                              sun1,
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'with Motion',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ])),
            ]),
          ),
          ConfettiView(
            controller: controller.homeConfettiController,
            confettiShapeEnum: ConfettiShapeEnum.drawHeart,
          ),
        ],
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
