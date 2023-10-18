import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';

import '../../utils/routes/routes_const.dart';
import '../../utils/services/firebase_login.dart';

class LoginController extends BaseController {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  RxnString errorEmailText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);
  RxBool obscurePassword = true.obs;

  void onEmailChanged(String email) {
    if (GetUtils.isEmail(email)) {
      errorEmailText.value = null;
    } else {
      errorEmailText.value = 'Enter valid email';
    }
  }

  void onPasswordChanged(String password) {
    if (password.isNotEmpty) {
      errorEmailText.value = null;
    } else {
      errorEmailText.value = 'Enter valid password';
    }
  }

  Future<void> loginWithEmail() async {
    showLoaderDialog(context: Get.context!);
    final firebaseAuthController = Get.find<FirebaseAuthController>();
    final data =
        await firebaseAuthController.loginWithEmail(email: emailTextController.text, password: passwordTextController.text);
    cancelLoaderDialog();
    if (data != null) {
      log('Login Data :: ${data.uid} -- ${data.email}');
      Get.offAllNamed(RoutesConst.dashboardScreen);
    }
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
