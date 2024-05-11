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
import '../auth_model/login_response_api.dart';
import '../auth_services/Auth_api_service.dart';

class LoginController extends BaseController {
  AuthApiService _authApiService = AuthApiService();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  RxnString errorEmailText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);
  RxBool obscurePassword = true.obs;
  LoginResponseApi loginResponseApi = LoginResponseApi();
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

 /* Future<void> loginWithEmail() async {
    showLoaderDialog(context: Get.context!);
    final firebaseAuthController = Get.find<FirebaseAuthController>();
    final data =
        await firebaseAuthController.loginWithEmail(email: emailTextController.text, password: passwordTextController.text);
    cancelLoaderDialog();
    if (data != null) {
      log('Login Data :: ${data.uid} -- ${data.email}');
      Get.offAllNamed(RoutesConst.dashboardScreen);
    }
  }*/

  Future<void> loginWithEmail() async {
    showLoaderDialog(context: Get.context!);
   // final firebaseAuthController = Get.find<FirebaseAuthController>();
    final response =
    await _authApiService.fetchLoginUser(email: emailTextController.text, password: passwordTextController.text);
    cancelLoaderDialog();
    if (response.message == 'Login Successful') {
      loginResponseApi = response;
      log('Login Data :: ${response.data?.username} -- ${response.data?.email}');
     if(loginResponseApi.data?.phoneNumber ==''){
       Get.toNamed(RoutesConst.profileSetUpScreen);
     }else {
       GetStorage().write(token, loginResponseApi.accessToken);
       GetStorage().write(userMobile, loginResponseApi.data?.phoneNumber);
       GetStorage().write(username, loginResponseApi.data?.username);
       GetStorage().write(email, loginResponseApi.data?.email);
       GetStorage().write(userId, loginResponseApi.data?.id);
       GetStorage().write(profile_url, loginResponseApi.data?.profilePicUrl);





       Get.offAllNamed(RoutesConst.dashboardScreen);
     }
    }
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
