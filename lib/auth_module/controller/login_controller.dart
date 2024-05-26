import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';

import '../../utils/routes/routes_const.dart';
import '../../utils/services/firebase_auth_controller.dart';
import '../auth_model/login_response_model.dart';
import '../auth_model/login_response_model.dart';
import '../auth_services/Auth_api_service.dart';

class LoginController extends BaseController {
  final AuthApiService _authApiService = AuthApiService();
  final phoneNumberController = TextEditingController();
  final passwordTextController = TextEditingController();

  RxnString errorPhoneNumberText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);

  RxBool obscurePassword = true.obs;
  LoginResponseModel loginResponseModel = LoginResponseModel();

  void onPhoneNumberChanged(String mobile) {
    if (mobile.length == 10) {
      errorPhoneNumberText.value = null;
    } else {
      errorPhoneNumberText.value = 'Enter valid mobile number';
    }
  }

  void onPasswordChanged(String password) {
    if (password.isNotEmpty) {
      errorPasswordText.value = null;
    } else {
      errorPasswordText.value = 'Enter valid password';
    }
  }

  Future<void> login() async {
    showLoaderDialog(context: Get.context!);
    final response = await _authApiService.fetchLoginUser(
        phoneNumber: phoneNumberController.text, password: passwordTextController.text);
    cancelLoaderDialog();
    if (response.message == 'Login Successful') {
      loginResponseModel = response;
      if (loginResponseModel.data?.phoneNumber == '') {
        Get.toNamed(RoutesConst.profileSetUpScreen);
      } else {
        GetStorage().write(token, loginResponseModel.data?.accessToken);
        GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber);
        GetStorage().write(username, loginResponseModel.data?.username);
        GetStorage().write(email, loginResponseModel.data?.email);
        GetStorage().write(userId, loginResponseModel.data?.id);
        GetStorage().write(profile_url, loginResponseModel.data?.profilePicUrl);
        Get.offAllNamed(RoutesConst.dashboardScreen);
      }
    }
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
