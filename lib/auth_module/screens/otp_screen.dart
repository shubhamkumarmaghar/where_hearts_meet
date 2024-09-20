import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/otp_screen_controller.dart';

class OtpScreen extends StatelessWidget {
  final controller = Get.find<OtpScreenController>();

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1, bottom: 30),
        color: appColor3,
        child: GradientButton(
          title: 'Submit',
          height: screenHeight * 0.06,
          width: screenWidth * 0.8,
          onPressed: controller.signInWithPhoneNumber,
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(gradient: backgroundGradient),
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
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('OTP Verification', style: textStyleDangrek(fontSize: 20)
                      // style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: blackColor),
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
              otpFieldWidget(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  controller.resendOTP();
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t receive the ',
                        style: textStyleAbel(),
                      ),
                      TextSpan(
                        text: 'OTP',
                        style: textStyleAbel(),
                      ),
                      TextSpan(
                        text: ' ?',
                        style: textStyleAbel(),
                      ),
                      TextSpan(
                        text: ' RESEND OTP',
                        style: textStyleAbel(fontWeight: FontWeight.w600, textDecoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.35,
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Center(
              //     child: GradientButton(
              //       title: 'Submit',
              //       height: screenHeight * 0.06,
              //       width: screenWidth * 0.8,
              //       onPressed: controller.signInWithPhoneNumber,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget otpFieldWidget() {
    final defaultPinTheme = PinTheme(
      width: screenHeight * 0.06,
      height: screenHeight * 0.06,
      textStyle: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      length: 6,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      controller: controller.otpController,
    );
  }
}
