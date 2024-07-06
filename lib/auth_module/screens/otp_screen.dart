import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../controller/guest_login_controller.dart';

class OTPScreen extends StatefulWidget {
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with SingleTickerProviderStateMixin {
  String otpCodeValue = '';

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  final controller = Get.find<GuestLoginController>();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  //   image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill,),
                  ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "OTP",
                              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text.rich(
                                TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Enter the 6-digit code sent to you \nat ',
                                      style: TextStyle(color: Colors.grey.shade700),
                                    ),
                                    TextSpan(
                                      text: controller.phoneNumberController.text,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: ' did you enter the \ncorrect Number',
                                      style: TextStyle(color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              )),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    OTPTextField(
                      controller: OtpFieldController(),
                      keyboardType: TextInputType.number,
                      isDense: false,
                      margin: const EdgeInsets.all(5),
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 40,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      contentPadding: const EdgeInsets.all(15),
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.grey.shade100,
                        focusBorderColor: Colors.black,
                        enabledBorderColor: Colors.black,
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
                        controller.verifyPhoneNumber();
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Don\'t receive the ',
                              style: TextStyle(color: Colors.black),
                            ),
                            const TextSpan(
                              text: 'OTP',
                              style: TextStyle(color: Colors.black),
                            ),
                            const TextSpan(
                              text: ' ?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' RESEND OTP',
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    controller.isLoading.value == true
                        ? const CupertinoActivityIndicator(
                            color: Colors.grey,
                            radius: 10,
                          ) // Show loading indicator while API call is in progress
                        : Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: primaryColor,
                            child: ElevatedButton(
                              onPressed: () async {
                                controller.signInWithPhoneNumber();
                              },
                              child: Text("Verify Phone Number"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
