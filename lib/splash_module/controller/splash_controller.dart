import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../onboarding_module/view/intro_screen.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/shared_pref_const.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    updateSplashView();
  }

  void updateSplashView() async {
    final bool login = GetStorage().read(isLoggedIn) ?? false;
    final bool guest = GetStorage().read(isGuest) ?? false;
    final bool isOnboarded = GetStorage().read(onboarding) ?? false;
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isOnboarded) {
      if (login) {
        if (guest) {
          Get.offAllNamed(RoutesConst.guestViewScreen);
        } else {
          Get.offAllNamed(RoutesConst.dashboardScreen);
        }
      } else {
        Get.offAllNamed(RoutesConst.loginScreen);
      }
    } else {
      Get.offAll(const IntroScreen());
    }
  }
}
