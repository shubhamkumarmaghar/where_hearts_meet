import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../repository/onboarding_repository.dart';
import 'onboarding_view.dart';
import '../../utils/consts/images_const.dart';
import '../widgets/intro_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  RxInt dotIndicator = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: backgroundGradientColors),
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight*0.04,
              ),
              Container(
                height: screenHeight*0.15,
                width: screenWidth*0.35,
                child: Image.asset(
                  logo,
                  fit: BoxFit.cover,

                ),
              ),
              Container(
                height: Get.height * 0.78,
                child: PageView.builder(
                  itemCount: getOnboardingData().length,
                  itemBuilder: (BuildContext context, index) {
                    var data = getOnboardingData()[index];
                    return IntroWidget(
                      onboardingModel: data,
                    );
                  },
                  onPageChanged: (value) {
                    dotIndicator.value = value;
                  },
                ),
              ),
              DotsIndicator(
                dotsCount: getOnboardingData().length,
                position: dotIndicator.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
