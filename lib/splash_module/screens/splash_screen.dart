import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/splash_module/controller/splash_controller.dart';
import 'package:where_hearts_meet/splash_module/util/animated_heart_widget.dart';
import 'dart:math' as math;

import 'package:where_hearts_meet/splash_module/util/splash_enum.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/confetti_shape_enum.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/widgets/confetti_view.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return SizedBox(height: screenHeight, width: screenWidth, child: Center(child: getAppLogo()));
        },
      ),
    );
  }

  Widget getAppLogo() {
    return Image.asset(
      logo,
      height: 250,
      width: 250,
    );
  }
}
