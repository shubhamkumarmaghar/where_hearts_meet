import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/onboarding_module/controller/onboarding_controller.dart';
import 'package:where_hearts_meet/onboarding_module/repository/onboarding_repository.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/widgets/gradient_button.dart';

class OnboardingScreen extends StatelessWidget {
  final onboardingController = Get.put(OnboardingController());
  final CardSwiperController controller = CardSwiperController();

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: appColor2,
        body: Container(
      height: screenHeight,
      width: screenWidth,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(appBackground2), fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: screenHeight * 0.15,
          ),
          Image.asset(
            logo,
            height: screenHeight * 0.35,
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Container(
            // color: Colors.amber,
            height: screenHeight * 0.17,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: loginWishesTextList.length,
              itemBuilder: (BuildContext context, index) {
                var data = loginWishesTextList[index];
                return SizedBox(
                    width: screenWidth * 0.75,
                    child: Text(
                      '* $data',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.start,
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(reverse: true), // loop
                        )
                        .shimmer(duration: const Duration(seconds: 3), color: yellowColor.withOpacity(0.7)));
              },
              separatorBuilder: (context, index) => SizedBox(
                height: screenHeight * 0.01,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.11,
          ),
          GradientButton(
            title: "I'm  Guest",
            width: Get.width * 0.8,
            buttonColor: primaryColor,
            height: screenHeight * 0.065,
            onPressed: () {
              final String? login = GetStorage().read(token);
              if (GetStorage().read(isGuest) == true &&
                  login != null && login != '') {
                Get.offAllNamed(RoutesConst.guestCoverScreen);
              }
              else{
                onboardingController.showGuestLoginDialog(
                  context: context,
                );
              }


            },
          ),
          SizedBox(height: Get.height * 0.02),
          getOutlinedButton(
              width: Get.width * 0.8,
              height: screenHeight * 0.065,
              child: const Text("Register/Sign-In",
                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: 16)),
              onPressed: () {
                GetStorage().remove(isGuest);
                Get.toNamed(RoutesConst.loginScreen);
              }),
        ]),
      ),
    ));
  }
}
