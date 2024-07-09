import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:motion/motion.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

import '../../../../utils/consts/confetti_shape_enum.dart';
import '../../../../utils/dialogs/pop_up_dialogs.dart';
import '../../../../utils/widgets/confetti_view.dart';
import '../controller/guest_home_controller.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({super.key});

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> with TickerProviderStateMixin {

  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<GuestHomeController>();

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
      body: controller.isBusy != true? Stack(
        children: [
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
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                controller.eventDetails!.coverPic??'',
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
                        ),

                    ),

                  ],
                ),

              Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Motion.elevated(
                  elevation: 300,
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
              Stack(children: [
                Container(
                  margin:EdgeInsets.only(left: 20),
                    height: Get.height*0.48,
                    width: Get.height*0.35,
                  decoration: BoxDecoration(border: Border.all(color: Colors.green),borderRadius: BorderRadius.all(Radius.circular(30)), image: DecorationImage(fit: BoxFit.cover,
                      image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/Black%20Minimalist%20Happy%20Birthday%20Poster%20(1).png?alt=media&token=13bada89-8df2-4c06-b98e-962a08ba929e') )),
               
                    ),Positioned(top: 50,left: 110,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.green,width: 3) ,borderRadius: BorderRadius.all(Radius.circular(30),)),
                      child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(26),),
                        child: Image.network('https://firebasestorage.googleapis.com/v0/b/where-hearts-meet.appspot.com/o/profilePics%2Fprofile_pic_DJ6wp0i9qdRJ6cgv43UO9FGXT9C3?alt=media&token=23077f90-d6b2-415e-a30d-401f4944499d',
                                          width: 150,
                                          height: 200,fit: BoxFit.cover,),
                      ),
                    ))
                
              ]),
              Center(
                child: Container(
                  width: Get.width*0.6,
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
                  child: Column(
                    children: [
                      // Profile section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'username',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '@handle · 1h',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Icon(Icons.more_vert),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'This is the content of the tweet. It can be multiple lines long and contain various types of content.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.chat_bubble_outline),
                          Icon(Icons.repeat),
                          Icon(Icons.favorite_border),
                          Icon(Icons.share),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
SizedBox(height: Get.height*0.1,)
            ]),
          ),
          ConfettiView(
            controller: controller.homeConfettiController,
            confettiShapeEnum: ConfettiShapeEnum.drawHeart,
          ),
        ],
      ):Center(child: CircularProgressIndicator(color: primaryColor,
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
