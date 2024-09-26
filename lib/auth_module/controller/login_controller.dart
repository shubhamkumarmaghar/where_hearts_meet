import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:heart_e_homies/auth_module/auth_model/otp_params_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';

class LoginController extends BaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  final phoneNumberController = TextEditingController();
  RxnString errorPhoneNumberText = RxnString(null);
  RxBool registeredSelected = true.obs;
  RxBool conditionsAccepted = false.obs;
  RxBool showSubmitButton = false.obs;




  void onPhoneNumberChanged(String mobile) {
    if (mobile.length == 10) {
      errorPhoneNumberText.value = null;
    } else {
      errorPhoneNumberText.value = 'Enter valid mobile number';
    }
    updateSubmitButtonStatus();
  }

  void updateSubmitButtonStatus() {
    showSubmitButton.value = phoneNumberController.text.length == 10 && conditionsAccepted.value;
  }

  void onChangeUserType(bool isRegistered) {
    registeredSelected.value = isRegistered;
  }

  Future<void> verifyPhoneNumber() async {
    if (showSubmitButton.value == false) {
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
        Get.toNamed(
          RoutesConst.otpScreen,
          arguments: OtpParamsModel(
            verificationId: _verificationId,
            phoneNumber: phoneNumberController.text,
            userType: registeredSelected.value ? UserType.registered : UserType.guest,
          ),
        );
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void onConditionsAccepted(bool? selected) {
    if (selected != null) {
      conditionsAccepted.value = selected;
      updateSubmitButtonStatus();
    }
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }
}
