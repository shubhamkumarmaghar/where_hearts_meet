import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/routes/routes_const.dart';
import '../../utils/services/firebase_auth_controller.dart';
import '../auth_model/response_register_model.dart';
import '../auth_services/Auth_api_service.dart';

class SignUpController extends BaseController {
  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  RxnString errorEmailText = RxnString(null);
  RxnString errorUserNameText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);
  RxnString errorConfirmPasswordText = RxnString(null);
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  AuthApiService _authApiService = AuthApiService();
  RegisterResponseModel registerResponseModel = RegisterResponseModel();
  void onEmailChanged(String email) {
    if (GetUtils.isEmail(email)) {
      errorEmailText.value = null;
    } else {
      errorEmailText.value = 'Enter valid email';
    }
  }

  void onUsernameChanged(String username) {
    if (username.isNotEmpty) {
      errorPasswordText.value = null;
    } else {
      errorUserNameText.value = 'Enter valid password';
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

  Future<void> createUserWithEmail() async {
    showLoaderDialog(context: Get.context!);
   // final firebaseAuthController = Get.find<FirebaseAuthController>();
    final response =
        await _authApiService.registerUser(email: emailTextController.text, password: passwordTextController.text,
        username:usernameTextController.text );
    if (response.message?.toLowerCase() == 'user registered successfully') {
      registerResponseModel = response;
      log('Create User Data :: ${response.accessToken} -- ${response.data?.email} ');
      Get.toNamed(RoutesConst.profileSetUpScreen);
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
