import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import '../../guest/guest_dashboard/view/guest_dashboard.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/routes/routes_const.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../auth_services/Auth_api_service.dart';
import '../screens/otp_screen.dart';

class GuestLoginController
extends BaseController {
  RxBool isLoading = false.obs;
  final AuthApiService _authApiService = AuthApiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  RxnString errorPhoneNumberText = RxnString(null);
  String _verificationId = '';


  void onPhoneNumberChanged(String mobile) {
    if (mobile.length == 10) {
      errorPhoneNumberText.value = null;
    } else {
      errorPhoneNumberText.value = 'Enter valid mobile number';
    }
  }

  Future<void> verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91'+phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        log('shubham');
          _verificationId = verificationId;
          Get.to(OTPScreen());

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
        print("Successfully signed in UID: ${user.uid}");
        GetStorage().write(isGuest, true);
        AppWidgets.getToast(message: 'Mobile number is successfully verified',color: primaryColor.withOpacity(0.2));
        Get.offAllNamed(RoutesConst.guestDashboard);
      //  Get.offAll(const GuestDashboard());
      } else {
        print("Failed to sign in");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}