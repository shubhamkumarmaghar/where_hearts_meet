import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heart_e_homies/auth_module/auth_model/otp_params_model.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../auth_model/login_response_model.dart';
import '../auth_services/Auth_api_service.dart';

class OtpScreenController extends BaseController {
  final TextEditingController otpController = TextEditingController();
  final AuthApiService _authApiService = AuthApiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  LoginResponseModel loginResponseModel = LoginResponseModel();
  late OtpParamsModel otpParamsModel;

  @override
  void onInit() {
    super.onInit();
    otpParamsModel = Get.arguments as OtpParamsModel;
    _verificationId = otpParamsModel.verificationId;
  }

  Future<void> resendOTP() async {
    showLoaderDialog(context: Get.context!);
    otpController.clear();
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${otpParamsModel.phoneNumber}",
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
        if (otpParamsModel.userType == UserType.registered) {
          _registeredLoginAndSignup(uid: user.uid);
        } else if (otpParamsModel.userType == UserType.guest) {
          _guestLoginAndSignup(uid: user.uid);
        }
      } else {
        log("Failed to sign in");
      }
    } catch (e) {
      AppWidgets.getToast(message: (e as FirebaseAuthException).message ?? "", color: errorColor);
    }
  }

  Future<void> _registeredLoginAndSignup({required String uid}) async {
    showLoaderDialog(context: Get.context!);
    final response = await _authApiService.fetchLoginUser(phoneNumber: otpParamsModel.phoneNumber, uid: uid);
    loginResponseModel = response;
    if (loginResponseModel.message != null && loginResponseModel.data != null) {
      var createdEvent = locator<CreatedEventRepo>();
      createdEvent.setUserType(UserType.registered);
      await Future.wait([
        GetStorage().write(token, loginResponseModel.data?.accessToken),
        GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber),
        GetStorage().write(username, loginResponseModel.data?.username),
        GetStorage().write(profileUrl, loginResponseModel.data?.profilePic),
        GetStorage().write(firstName, loginResponseModel.data?.firstName),
        GetStorage().write(isLoggedIn, true),
        GetStorage().write(isGuest, false),

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

  Future<void> _guestLoginAndSignup({required String uid}) async {
    showLoaderDialog(context: Get.context!);
    final response =
        await _authApiService.fetchLoginUser(phoneNumber: otpParamsModel.phoneNumber, uid: uid, isGuest: true);
    if (response.message != null && response.data != null) {

      cancelDialog();
      AppWidgets.showSnackBar(context: Get.context!, message: '${response.message}', color: greenTextColor);
      if (response.message!.toLowerCase().contains('guest')) {
        var createdEvent = locator<CreatedEventRepo>();
        createdEvent.setUserType(UserType.guest);
        GetStorage().write(token, response.data?.accessToken);
        GetStorage().write(userMobile, response.data?.phoneNumber);
        GetStorage().write(username, response.data?.username);
        GetStorage().write(isGuest, true);
        GetStorage().write(isLoggedIn, true);
        Get.offAllNamed(RoutesConst.guestViewScreen);
      }
    } else {
      cancelDialog();
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
