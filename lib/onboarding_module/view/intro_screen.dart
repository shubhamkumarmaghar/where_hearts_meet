import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/onboarding_module/repository/onboarding_repository.dart';

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
          ()=> Container(
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
          child: Column(
            children: [
              SizedBox(height: 26,),
              Hero(tag: 'logo',
              child: Image.asset(logo,height: 130,width: 130,)),
              Container(
                height: Get.height*0.78,
                child: PageView.builder(
                    itemCount: getOnboardingData().length,
                    itemBuilder: (BuildContext context, index)  {
                      var data = getOnboardingData()[index];
                    return IntroWidget(onboardingModel: data,);
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
