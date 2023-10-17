import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class SignUpController extends BaseController{
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  RxnString errorEmailText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);
  RxnString errorConfirmPasswordText = RxnString(null);
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  void onEmailChanged(String email) {
    if (GetUtils.isEmail(email)) {
      errorEmailText.value = null;
    } else {
      errorEmailText.value = 'Enter valid email';
    }
  }
  void onPasswordChanged(String password) {
    if (password.isNotEmpty) {
      errorPasswordText.value = null;
    } else {
      errorPasswordText.value = 'Enter valid password';
    }
  }
  void onConfirmPasswordChanged(String confirmPassword) {
    if (confirmPassword.isNotEmpty) {
      errorConfirmPasswordText.value = null;
    } else {
      errorConfirmPasswordText.value = 'Enter valid password';
    }
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.onClose();
  }
}