import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/images_const.dart';
import '../controller/splash_controller.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Container(
              decoration: BoxDecoration(
                gradient:LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff9467ff),
                    Color(0xffae8bff),
                    Color(0xffc7afff),
                    Color(0xffdfd2ff),
                    Color(0xfff2edff),
                  ]
              ),),
              height: screenHeight, width: screenWidth, child: Center(child: getAppLogo()));
        },
      ),
    );
  }

  Widget getAppLogo() {
    return Hero(
      tag: 'logo',
      child: Image.asset(
        logo,
        height: 250,
        width: 250,
      ),
    );
  }
}
