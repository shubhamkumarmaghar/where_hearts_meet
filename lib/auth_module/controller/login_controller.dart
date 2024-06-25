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
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../auth_model/login_response_model.dart';
import '../auth_model/login_response_model.dart';
import '../auth_services/Auth_api_service.dart';

class LoginController extends BaseController {
  final AuthApiService _authApiService = AuthApiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  final passwordTextController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String _verificationId = '';
  RxnString errorPhoneNumberText = RxnString(null);
  RxnString errorPasswordText = RxnString(null);
  RxBool otpSent= false.obs;
  RxBool isLoading = false.obs;
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

  // Future<void> login() async {
  //   showLoaderDialog(context: Get.context!);
  //   final response = await _authApiService.fetchLoginUser(
  //       phoneNumber: phoneNumberController.text,
  //       password: passwordTextController.text);
  //
  //   cancelLoaderDialog();
  //   if (response.message == 'Login Successful') {
  //     loginResponseModel = response;
  //     if (loginResponseModel.data?.phoneNumber == '') {
  //       Get.toNamed(RoutesConst.profileSetUpScreen);
  //     } else {
  //       GetStorage().write(token, loginResponseModel.data?.accessToken);
  //       GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber);
  //       GetStorage().write(username, loginResponseModel.data?.username);
  //       GetStorage().write(profileUrl, loginResponseModel.data?.profilePicUrl);
  //       GetStorage().write(firstName, loginResponseModel.data?.firstName);
  //
  //       Get.offAllNamed(RoutesConst.dashboardScreen);
  //     }
  //   }
  // }
  Future<void> verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91"+phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        log('shubham');
        _verificationId = verificationId;
        otpSent.value = true;
        //Get.to(OTPScreen());

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> signInWithPhoneNumber() async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        log("Successfully signed in UID: ${user.uid}");
        AppWidgets.getToast(message: 'Mobile number is successfully verified');
        loginAndSignup(uid: user.uid);

       // Get.offAll(const GuestDashboard());
      } else {
        log("Failed to sign in");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> loginAndSignup({required String uid}) async {
    showLoaderDialog(context: Get.context!);
    final response = await _authApiService.fetchLoginUser(
        phoneNumber: phoneNumberController.text,
        uid: uid);
        //password: passwordTextController.text);
    cancelLoaderDialog();
    loginResponseModel = response;
    if (response.message == 'Login Successful') {


      if (loginResponseModel.data?.phoneNumber == '') {
        await GetStorage().write(token, loginResponseModel.data?.accessToken);
       // Get.toNamed(RoutesConst.profileSetUpScreen);
      } else {
        GetStorage().write(token, loginResponseModel.data?.accessToken);
        GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber);
        GetStorage().write(username, loginResponseModel.data?.username);
        GetStorage().write(profileUrl, loginResponseModel.data?.profilePicUrl);
        GetStorage().write(firstName, loginResponseModel.data?.firstName);

        Get.offAllNamed(RoutesConst.dashboardScreen);
      }
    }
    log('before ${loginResponseModel.toJson()}-----after${response.toJson()}');
    if (response.message!.toLowerCase().contains('user registered')) {

      GetStorage().write(token, loginResponseModel.data?.accessToken);
      GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber);
      GetStorage().write(username, loginResponseModel.data?.username);
      GetStorage().write(profileUrl, loginResponseModel.data?.profilePicUrl);
      GetStorage().write(firstName, loginResponseModel.data?.firstName);

      Get.offAllNamed(RoutesConst.profileSetUpScreen);
    }
  }


  @override
  void onClose() {
    phoneNumberController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
