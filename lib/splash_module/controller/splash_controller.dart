import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_screen.dart';
import 'package:where_hearts_meet/splash_module/util/splash_enum.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';

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
    if (login != null && login != '') {
      Get.offAllNamed(RoutesConst.dashboardScreen);
    } else {
      Get.offAllNamed(RoutesConst.loginScreen);
    }
  }
}
