import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/routes/routes_const.dart';
import '../../utils/services/firebase_auth_controller.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../auth_model/response_register_model.dart';
import '../auth_services/Auth_api_service.dart';

class SignUpController extends BaseController {
  final emailTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  RxnString errorEmailText = RxnString(null);
  RxnString errorMobileText = RxnString(null);
  RxnString errorUserNameText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);
  RxnString errorConfirmPasswordText = RxnString(null);
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  RxBool enableSignUpButton = false.obs;

  final AuthApiService _authApiService = AuthApiService();
  RegisterResponseModel registerResponseModel = RegisterResponseModel();

  void onEmailChanged(String email) {
    if (GetUtils.isEmail(email)) {
      errorEmailText.value = null;
    } else {
      errorEmailText.value = 'Enter valid email';
    }
    _hasSignUpButtonEnabled();
  }

  void onMobileNumberChanged(String mobile) {
    if (mobile.length == 10) {
      errorMobileText.value = null;
    } else {
      errorMobileText.value = 'Enter valid mobile number';
    }
    _hasSignUpButtonEnabled();
  }

  void _hasSignUpButtonEnabled() {
    if (emailTextController.text.isNotEmpty &&
        errorEmailText.value == null &&
        usernameTextController.text.isNotEmpty &&
        errorUserNameText.value == null &&
        passwordTextController.text.isNotEmpty &&
        errorPasswordText.value == null &&
        confirmPasswordTextController.text == passwordTextController.text) {
      enableSignUpButton.value = true;
    } else {
      enableSignUpButton.value = false;
    }
  }

  void onUsernameChanged(String username) {
    if (username.isNotEmpty) {
      errorPasswordText.value = null;
    } else {
      errorUserNameText.value = 'Enter valid password';
    }
    _hasSignUpButtonEnabled();
  }

  void onPasswordChanged(String password) {
    if (password.isNotEmpty && password.length > 7) {
      errorPasswordText.value = null;
    } else {
      errorPasswordText.value = 'Enter valid password';
    }
    _hasSignUpButtonEnabled();
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    if (confirmPassword.isNotEmpty && confirmPassword.length > 7) {
      errorConfirmPasswordText.value = null;
    } else {
      errorConfirmPasswordText.value = 'Enter valid password';
    }
    _hasSignUpButtonEnabled();
  }

  Future<void> createUser() async {
    showLoaderDialog(context: Get.context!);

    if (passwordTextController.text != confirmPasswordTextController.text) {
      AppWidgets.getToast(message: 'Password and confirm password is not matching.', color: redColorError);
      return;
    }
    final response = await _authApiService.registerUser(
        email: emailTextController.text,
        password: passwordTextController.text,
        username: usernameTextController.text,
        mobileNumber: mobileTextController.text);

    cancelLoaderDialog();
    if (response.message?.toLowerCase() == 'user registered successfully') {
      registerResponseModel = response;
      await GetStorage().write(token, response.accessToken);
      Get.offAllNamed(RoutesConst.profileSetUpScreen);
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
