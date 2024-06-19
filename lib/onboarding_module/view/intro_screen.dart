import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding_view.dart';
import '../../utils/consts/images_const.dart';
import 'onboarding.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<OnboardingModel> onboarding = [
    OnboardingModel(
      text: 'Your Ultimate Gift Guide',
      img: intro5,
      url:
      'https://i.pinimg.com/originals/71/6e/fc/716efc545dbb2b0e2a018bed028b26f7.jpg',
    ),
    OnboardingModel(
        text: 'Create Memorable Moments',
        img: intro4,
        url:
        'https://i0.wp.com/shaadiwish.com/blog/wp-content/uploads/2021/12/roka-couple-pictures-810x1024.jpeg'),
    OnboardingModel(
        text: 'Surprise & Delight',
        img: intro3,
        url:
        'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/02c28eda-4c2b-4051-8177-c24a3338489c/dg1y18w-7790bafd-abf1-4826-a474-287710a923ad.png/v1/fit/w_512,h_512,q_70,strp/love_couple_in_violet_dress_by_ecstasyai_dg1y18w-375w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTEyIiwicGF0aCI6IlwvZlwvMDJjMjhlZGEtNGMyYi00MDUxLTgxNzctYzI0YTMzMzg0ODljXC9kZzF5MTh3LTc3OTBiYWZkLWFiZjEtNDgyNi1hNDc0LTI4NzcxMGE5MjNhZC5wbmciLCJ3aWR0aCI6Ijw9NTEyIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.0dZ873Dpdn11oFEcCNsF6N_YM0ztohApNH3ghtp63TI'),
    OnboardingModel(
      text: 'Easy Fun & Personal',
      img: intro2,
      url:
      'https://i.pinimg.com/originals/71/6e/fc/716efc545dbb2b0e2a018bed028b26f7.jpg',
    ),
    OnboardingModel(
        text: 'Gift Inspiration just a click away',
        img: intro1,
        url:
        'https://i0.wp.com/shaadiwish.com/blog/wp-content/uploads/2021/12/roka-couple-pictures-810x1024.jpeg'),
  ];
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
                    itemCount: onboarding.length,
                    itemBuilder: (BuildContext context, index)  {
                    return IntroWidget(onboardingModel: onboarding[index],);
                  },
                    onPageChanged: (value) {
              dotIndicator.value = value;
              },
                ),

              ),
              DotsIndicator(
                dotsCount: onboarding.length,
                position: dotIndicator.value,
              ),
            ],
          ),
        ),
      ),
    );

  }


}
