
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:where_hearts_meet/auth_module/controller/login_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/widgets/gradient_button.dart';

class LoginOtpScreen extends StatelessWidget {
  final controller = Get.find<LoginController>();

  LoginOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: appColor3,
        padding: EdgeInsets.only(left: 16, right: 16, top: screenHeight * 0.08),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: blackColor),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                  height: 200, child: Image.network('https://cdn.templates.unlayer.com/assets/1636374086763-hero.png')),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              OTPTextField(
                controller: OtpFieldController(),
                keyboardType: TextInputType.number,
                isDense: false,
                margin: const EdgeInsets.all(5),
                length: 6,
                width: screenWidth * 0.85,
                fieldWidth: screenWidth*0.1,
                fieldStyle: FieldStyle.underline,
                outlineBorderRadius: 10,
                contentPadding: const EdgeInsets.all(12),
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: Colors.white,
                  focusBorderColor: primaryColor,
                  enabledBorderColor: primaryColor,
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (pin) {
                  controller.otpController.text = pin;
                },
                onCompleted: (pin) {
                  controller.otpController.text = pin;
                },
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  controller.resendOTP();
                },
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
              SizedBox(
                height: screenHeight * 0.35,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: GradientButton(
                    title: 'Submit',
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.8,
                    onPressed:controller.signInWithPhoneNumber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Widget child;
  final Animation<double> animation;

  const AnimatedLogo({Key? key, required this.animation, required this.child}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: child,
      ),
    );
  }
}
