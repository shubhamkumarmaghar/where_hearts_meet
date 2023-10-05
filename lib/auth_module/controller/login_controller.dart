import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

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

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
