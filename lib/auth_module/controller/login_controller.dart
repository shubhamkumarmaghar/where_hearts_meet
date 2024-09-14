import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../auth_model/login_response_model.dart';
import '../auth_services/Auth_api_service.dart';
import '../screens/login_otp_screen.dart';

class LoginController extends BaseController {
  final AuthApiService _authApiService = AuthApiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String _verificationId = '';
  RxnString errorPhoneNumberText = RxnString(null);

  RxBool isLoading = false.obs;
  LoginResponseModel loginResponseModel = LoginResponseModel();

  void onPhoneNumberChanged(String mobile) {
    if (mobile.length == 10) {
      errorPhoneNumberText.value = null;
    } else {
      errorPhoneNumberText.value = 'Enter valid mobile number';
    }
  }

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
        log('otp verification failed :: ${e.message}');
        AppWidgets.showSnackBar(context: Get.context!, message: '${e.message?.toString()}');
        cancelDialog();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        cancelDialog();
        AppWidgets.getToast(message: 'OTP sent', color: greenTextColor);
        Get.to(LoginOtpScreen());
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
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
    final response = await _authApiService.fetchLoginUser(phoneNumber: phoneNumberController.text, uid: uid);
    loginResponseModel = response;
    if (loginResponseModel.message != null && loginResponseModel.data != null) {
      await Future.wait([
        GetStorage().write(token, loginResponseModel.data?.accessToken),
        GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber),
        GetStorage().write(username, loginResponseModel.data?.username),
        GetStorage().write(profileUrl, loginResponseModel.data?.profilePic),
        GetStorage().write(firstName, loginResponseModel.data?.firstName),
      ]);
      cancelDialog();
      AppWidgets.showSnackBar(context: Get.context!, message: '${response.message}', color: greenTextColor);
      if (loginResponseModel.message!.toLowerCase().contains('user logged in successfully')) {
        Get.offAllNamed(RoutesConst.dashboardScreen);
      } else if (loginResponseModel.message!.toLowerCase().contains('register')) {
        Get.toNamed(RoutesConst.profileScreen, arguments: Screens.fromSignup);
      }
    } else {
      cancelDialog();
      AppWidgets.showSnackBar(context: Get.context!, message: 'Something went wrong!');
    }
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }
}
