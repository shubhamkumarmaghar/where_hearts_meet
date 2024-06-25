import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:where_hearts_meet/auth_module/controller/login_controller.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_text.dart';
import 'package:where_hearts_meet/utils/widgets/triangle_custom_painter.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/routes/routes_const.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<LoginController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseContainer(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SizedBox(
            height: _mainHeight,
            width: _mainWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: _mainHeight,
                    child: Stack(
                      children: [
                        getLoginBackground(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              logo,
                              height: 100,
                              width: 100,
                            ),
                            const Text(
                              'Welcome  back',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: _mainHeight * 0.53,
                              margin: EdgeInsets.only(
                                  left: _mainWidth * 0.06,
                                  right: _mainWidth * 0.06),
                              width: _mainWidth,
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 30),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => CustomTextField(
                                            title: 'Mobile Number',
                                            error: controller
                                                .errorPhoneNumberText.value,
                                            inputType: TextInputType.phone,
                                            hint: 'Please enter mobile number',
                                            onChanged:
                                                controller.onPhoneNumberChanged,
                                            controller: controller
                                                .phoneNumberController),
                                      ),

                                      // InkWell(
                                      //   onTap: () async {
                                      //     controller.verifyPhoneNumber();
                                      //   },
                                      //   child: Container(
                                      //       alignment: Alignment.centerRight,
                                      //       child: const Text(
                                      //         'Send Otp',
                                      //         style: TextStyle(
                                      //             color: primaryColor,
                                      //             fontWeight: FontWeight.w600,
                                      //             fontSize: 16,
                                      //             decoration:
                                      //                 TextDecoration.underline),
                                      //       )),
                                      // ),
                                      Obx(
                                        () => controller.otpSent.value == true
                                            ? Column(children: [
                                                OTPTextField(
                                                  controller:
                                                      OtpFieldController(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  isDense: false,
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  length: 6,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  textFieldAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  fieldWidth: 40,
                                                  fieldStyle: FieldStyle.box,
                                                  outlineBorderRadius: 15,
                                                  contentPadding:
                                                      const EdgeInsets.all(15),
                                                  otpFieldStyle: OtpFieldStyle(
                                                    backgroundColor:
                                                        Colors.grey.shade100,
                                                    focusBorderColor:
                                                        Colors.black,
                                                    enabledBorderColor:
                                                        Colors.black,
                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  onChanged: (pin) {
                                                    controller.otpController
                                                        .text = pin;
                                                  },
                                                  onCompleted: (pin) {
                                                    controller.otpController
                                                        .text = pin;
                                                  },
                                                ),
                                                const SizedBox(height: 15),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .verifyPhoneNumber();
                                                  },
                                                  child: const Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Don\'t receive the ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        TextSpan(
                                                          text: 'OTP',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        TextSpan(
                                                          text: ' ?',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        TextSpan(
                                                          text: ' RESEND OTP',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                    textHeightBehavior:
                                                        TextHeightBehavior(
                                                            applyHeightToFirstAscent:
                                                                false),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),

                                                // Obx(
                                                //   () => CustomTextField(
                                                //     title: 'Password',
                                                //     error: controller.errorPasswordText.value,
                                                //     hint: 'Please enter password',
                                                //     obscureText: controller.obscurePassword.value,
                                                //     onChanged: controller.onPasswordChanged,
                                                //     controller: controller.passwordTextController,
                                                //     suffix: InkWell(
                                                //       onTap: () =>
                                                //           controller.obscurePassword.value = !controller.obscurePassword.value,
                                                //       child: Container(
                                                //           padding: const EdgeInsets.only(right: 10),
                                                //           child: const Icon(
                                                //             Icons.remove_red_eye_outlined,
                                                //             color: blackColor,
                                                //             size: 15,
                                                //           )),
                                                //     ),
                                                //   ),
                                                // ),
                                                // SizedBox(
                                                //   height: _mainHeight * 0.02,
                                                // ),
                                                // InkWell(
                                                //   onTap: () async {},
                                                //   child: Container(
                                                //       alignment: Alignment.centerRight,
                                                //       child: const Text(
                                                //         'Forgot Password ?',
                                                //         style: TextStyle(
                                                //             color: primaryColor,
                                                //             fontWeight: FontWeight.w600,
                                                //             fontSize: 16,
                                                //             decoration: TextDecoration.underline),
                                                //       )),
                                                // ),
                                                SizedBox(
                                                  height: _mainHeight * 0.1,
                                                ),
                                                controller.isLoading.value ==
                                                        true
                                                    ? const CupertinoActivityIndicator(
                                                        color: Colors.grey,
                                                        radius: 10,
                                                      )
                                                    : Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Center(
                                                          child: GradientButton(
                                                            title: 'Login',
                                                            height:
                                                                _mainHeight *
                                                                    0.06,
                                                            width: _mainWidth *
                                                                0.8,
                                                            onPressed:
                                                                () async {
                                                              controller
                                                                  .signInWithPhoneNumber();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: _mainHeight * 0.025,
                                                ),
                                              ])
                                            : Container(margin: EdgeInsets.only(bottom: 20),
                                              child: GradientButton(
                                                title: 'Send Otp',
                                                height:
                                                _mainHeight *
                                                    0.06,
                                                width: _mainWidth *
                                                    0.8,
                                                onPressed:
                                                    () async {
                                                      controller.verifyPhoneNumber();
                                                },
                                              ),
                                            ),
                                      ),

                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Get.offAllNamed(RoutesConst.signUpScreen);
                                      //   },
                                      //   child: Container(
                                      //     child: const Row(
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       children: [
                                      //         Text('Don\'t have an account ?  ',
                                      //             style: TextStyle(
                                      //               color: blackColor,
                                      //               fontWeight: FontWeight.w600,
                                      //               fontSize: 16,
                                      //             )),
                                      //         Text(
                                      //           'Create one',
                                      //           style: TextStyle(
                                      //               color: primaryColor,
                                      //               fontWeight: FontWeight.w600,
                                      //               fontSize: 16,
                                      //               decoration: TextDecoration.underline),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginBackground() {
    return SizedBox(
      height: _mainHeight,
      width: _mainWidth,
      child: Column(
        children: [
          const Spacer(),
          CustomPaint(
            painter: TrianglePainter(
              strokeColor: primaryColor,
              strokeWidth: 1,
              paintingStyle: PaintingStyle.fill,
            ),
            child: SizedBox(
              height: _mainHeight * 0.6,
              width: _mainWidth,
            ),
          )
        ],
      ),
    );
  }
}
