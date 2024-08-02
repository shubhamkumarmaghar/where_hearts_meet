
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import '../../onboarding_module/view/intro_screen.dart';
import '../../onboarding_module/view/onboarding_view.dart';
import '../../routes/routes_const.dart';


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
      if (GetStorage().read(onboarding) == true) {
        Get.offAll( OnboardingScreen());
        // if (GetStorage().read(isGuest) == true &&
        //     login != null && login != '') {
        //   Get.offAllNamed(RoutesConst.guestCoverScreen);
        // } else {
        //   Get.offAll(const IntroScreen());
        //
        // }
      } else {
        Get.offAll(const IntroScreen());
      }
    }
  }
}
