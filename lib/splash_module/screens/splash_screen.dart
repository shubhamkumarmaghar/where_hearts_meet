import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/splash_module/controller/splash_controller.dart';
import 'package:where_hearts_meet/splash_module/util/animated_heart_widget.dart';
import 'dart:math' as math;

import 'package:where_hearts_meet/splash_module/util/splash_enum.dart';
import 'package:where_hearts_meet/utils/consts/confetti_shape_enum.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/widgets/confetti_view.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_text.dart';

class SplashScreen extends StatelessWidget {
  var _mainHeight;
  var _mainWidth ;

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _mainHeight=MediaQuery.of(context).size.height;
    _mainWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          log(controller.splashEnum.name);
          return SizedBox(
            height: _mainHeight,
            width: _mainWidth,
            child:    Center(child: getAppLogo())
            /*Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                controller.splashEnum == SplashEnum.showBrokenHeart
                    ? getBrokenHeartView()
                    : controller.splashEnum == SplashEnum.showShiningHeart
                        ? Container(
                            padding: EdgeInsets.only(top: _mainHeight * 0.3, left: _mainWidth * 0.25),
                            child: getShiningHeartView())
                        : controller.splashEnum == SplashEnum.showSplashTitle
                            ? Container(
                                padding: EdgeInsets.only(
                                  top: _mainHeight * 0.45,
                                ),
                                child: Column(
                                  children: [
                                    ConfettiView(
                                      controller: controller.controllerTopCenter,
                                      confettiShapeEnum: ConfettiShapeEnum.drawHeart,
                                    ),
                                    getAppTitle()
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                SizedBox(
                  height: _mainHeight * 0.04,
                )
              ],
            ),*/
          );
        },
      ),
    );
  }

  Widget getBrokenHeartView() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: _mainHeight * 0.342,
              width: _mainWidth * 0.385,
              child: Transform.rotate(
                angle: -math.pi / 7,
                child: const AnimatedHearts(
                  beginOffset: Offset(0.1, -0.1),
                  endOffset: Offset(0.2, 0.9),
                ),
              ),
            ),
            SizedBox(
              height: _mainHeight * 0.342,
              width: _mainWidth * 0.385,
              child: Transform.rotate(
                angle: -math.pi / 0.56,
                child: const AnimatedHearts(
                  beginOffset: Offset(0.2, -0.25),
                  endOffset: Offset(1.0, 0.9),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: _mainHeight * 0.2,
        ),
        Row(
          children: [
            SizedBox(
              height: _mainHeight * 0.342,
              width: _mainWidth * 0.385,
              child: Transform.rotate(
                angle: -math.pi / 1.18,
                child: const AnimatedHearts(
                  beginOffset: Offset(-0.5, -0.5),
                  endOffset: Offset(-0.2, 0.8),
                ),
              ),
            ),
            SizedBox(
              height: _mainHeight * 0.342,
              width: _mainWidth * 0.385,
              child: Transform.rotate(
                angle: -math.pi / 0.31,
                child: const AnimatedHearts(
                  beginOffset: Offset(0.3, -0.65),
                  endOffset: Offset(-0.8, 0.7),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getShiningHeartView() {
    return Image.asset(
      shiningHeartImage,
      height: 200,
      width: 200,
    );
  }
  Widget getAppLogo() {
    return Image.asset(
      logo,
      height: 250,
      width: 250,
    );
  }

  Widget getAppTitle() {
    log('called');
    return GradientText(
      text: '𝓦𝓱𝓮𝓻𝓮 \u2764 \'𝓼  𝓜𝓮𝓮𝓽 ',
      gradient: LinearGradient(
        colors: [
          Colors.red.shade400,
          Colors.blue.shade400,
          Color(0XFFFF0000),
          Color(0XFFFF0000),
          Colors.yellow.shade600,
          Colors.red.shade700,
        ],
      ),
      style: TextStyle(fontSize: _mainWidth * 0.15),
    );
  }
}
