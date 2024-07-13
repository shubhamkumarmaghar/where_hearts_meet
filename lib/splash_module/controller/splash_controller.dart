import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/splash_module/util/splash_enum.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';

import '../../guest/guest_dashboard/view/guest_splash_view.dart';
import '../../onboarding_module/view/intro_screen.dart';
import '../../onboarding_module/widgets/intro_widget.dart';
import '../../onboarding_module/view/onboarding_view.dart';
import '../../utils/services/firebase_auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    updateSplashView();
  }

  void updateSplashView() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final String? login = GetStorage().read(token);


    if (login != null && login != '' && GetStorage().read(isGuest) != true) {

      Get.offAllNamed(RoutesConst.dashboardScreen);
    } else {
      if( GetStorage().read(onboarding)==true){
      //  Get.offAll(OnboardingScreen());
        if(GetStorage().read(isGuest)==true && login != null && login != ''){
          Get.offAllNamed(RoutesConst.guestCoverScreen);
        }
        else {
          Get.offAll(OnboardingScreen());
        }
      }
      else {
        Get.offAll(const IntroScreen());
      }
    }
  }
}
