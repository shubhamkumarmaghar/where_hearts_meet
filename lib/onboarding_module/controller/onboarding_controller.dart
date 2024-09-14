import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../auth_module/auth_services/Auth_api_service.dart';
import '../../routes/routes_const.dart';
import '../../utils/buttons/buttons.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/consts/widget_styles.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';

import '../../utils/widgets/util_widgets/app_widgets.dart';

class OnboardingController extends BaseController {
  final phoneNumberController = TextEditingController();
  final AuthApiService _authApiService = AuthApiService();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  Future<void> verifyPhoneNumber() async {

    if (phoneNumberController.text.isEmpty || phoneNumberController.text.length != 10) {
      AppWidgets.getToast(message: 'Please enter valid phone number');
      return;
    }
    showLoaderDialog(context: Get.context!);
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        AppWidgets.showSnackBar(context: Get.context!, message: '${e.message?.toString()}');
        cancelDialog();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        cancelDialog();
        AppWidgets.getToast(message: 'OTP sent', color: greenTextColor);
        _showOTPDialog();
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> signInWithPhoneNumber() async {
    if (otpController.text.isEmpty || otpController.text.length != 6) {
      AppWidgets.getToast(message: 'Please enter valid otp code');
      return;
    }
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpController.text,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        AppWidgets.getToast(message: 'Mobile number is successfully verified',color: greenTextColor);
        loginAndSignup(uid: user.uid);
      } else {
        log("Failed to sign in");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> loginAndSignup({required String uid}) async {
    showLoaderDialog(context: Get.context!);
    final response = await _authApiService.fetchLoginUser(phoneNumber: phoneNumberController.text, uid: uid,
    isGuest: true);
    if (response.message != null && response.data != null) {
      await Future.wait([
        GetStorage().write(token, response.data?.accessToken),
      ]);
      cancelDialog();
      AppWidgets.showSnackBar(context: Get.context!, message: '${response.message}', color: greenTextColor);
      if (response.message!.toLowerCase().contains('guest')) {
        GetStorage().write(token, response.data?.accessToken);
    GetStorage().write(userMobile, response.data?.phoneNumber);
    GetStorage().write(username, response.data?.username);
    GetStorage().write(profileUrl, response.data?.profilePic);
    GetStorage().write(isGuest, true);
    Get.offAllNamed(RoutesConst.guestDashboard);
    //Get.offAllNamed(RoutesConst.guestCoverScreen);
      }
    } else {
      cancelDialog();
    }
  }
  Future<void> resendOTP() async {
    showLoaderDialog(context: Get.context!);
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('otp verification failed :: ${e.message}');
        AppWidgets.showSnackBar(context: Get.context!, message: '${e.message?.toString()}');
        cancelDialog();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        cancelDialog();
        AppWidgets.getToast(message: 'OTP sent', color: greenTextColor);
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _showOTPDialog() {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SizedBox(
        height: screenHeight * 0.45,
        child: Container(
          height: screenHeight * 0.38,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              Image.asset(
                logo,
                height: screenHeight * 0.15,
              ),
              Text(
                'We have sent otp to (+91) ${phoneNumberController.text}  ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              OTPTextField(
                controller: OtpFieldController(),
                keyboardType: TextInputType.number,
                isDense: false,
                // margin: const EdgeInsets.all(5),
                length: 6,
                width: screenWidth * 0.7,
                fieldWidth: screenWidth * 0.1,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 10,
                contentPadding: const EdgeInsets.all(12),
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: Colors.white,
                  focusBorderColor: blackColor,
                  enabledBorderColor: blackColor,
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (pin) {
                  otpController.text = pin;
                },
                onCompleted: (pin) {
                  otpController.text = pin;
                },
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: resendOTP,
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t receive the ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'OTP',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' ?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' RESEND OTP',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                children: [
                  getOutlinedButton(
                      width: Get.width * 0.3,
                      borderRadius: 15,
                      height: screenHeight * 0.05,
                      child: const Text("Cancel",
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500, fontSize: 16)),
                      onPressed: () =>Get.back()),
                  const Spacer(),
                  getElevatedButton(
                      width: Get.width * 0.3,
                      borderRadius: 15,
                      height: screenHeight * 0.05,
                      child: const Text("Verify",
                          style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500, fontSize: 16)),
                      onPressed:signInWithPhoneNumber
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showGuestLoginDialog({required BuildContext context}) {

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SizedBox(
        height: screenHeight * 0.42,
        child: Stack(
          children: [
            Container(
              height: screenHeight * 0.38,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  Image.asset(
                    logo,
                    height: screenHeight * 0.12,
                    width: screenWidth * 0.45,
                  ),
                  SizedBox(
                    height: screenHeight * 0.06,
                    child: const Row(
                      children: [
                        Text(
                          '(+91)  ',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
                        ),
                        Text(
                          'India',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 20,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      hintText: 'Enter your mobile number',
                      errorMaxLines: 3,
                      hintStyle: const TextStyle(color: Colors.grey),
                      errorBorder: BorderStyles.errorBorder,
                      errorStyle: TextStyles.errorStyle,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  SizedBox(
                      width: screenWidth * 0.5,
                      child: const Text(
                        'We will send you one time password  (OTP)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                      )),
                ],
              ),
            ),
            Positioned(
              left: screenWidth * 0.33,
              right: screenWidth * 0.33,
              bottom: screenHeight * 0.01,
              child: GestureDetector(
                onTap: () async {
                  cancelDialog();
                  await verifyPhoneNumber();
                },
                child: Container(
                  height: screenHeight * 0.06,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  // alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
