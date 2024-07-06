import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/controller/login_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/widget_styles.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.find<LoginController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      getLoginBackground(),
                      Positioned(
                        top: 120,
                        left: 5,
                        right: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Welcome  to',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  shadows: [
                                    Shadow(color: Colors.red, blurRadius: 2.0),
                                  ]),
                            ),
                            Image.asset(
                              logo,
                              height: 150,
                              width: 150,
                            ),
                            Container(
                              height: 300,
                              margin: EdgeInsets.only(left: screenWidth * 0.07, right: screenWidth * 0.07),
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 45,
                                    child: Row(
                                      children: [
                                        Text(
                                          '(+91)  ',
                                          style:
                                              TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
                                        ),
                                        Text(
                                          'India',
                                          style:
                                              TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    style:
                                        const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                                    onChanged: controller.onPhoneNumberChanged,
                                    controller: controller.phoneNumberController,
                                    decoration: InputDecoration(
                                      //errorText: controller.errorPhoneNumberText.value,
                                      hintText: 'Enter your mobile number',
                                      errorMaxLines: 3,
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      errorBorder: BorderStyles.errorBorder,
                                      errorStyle: TextStyles.errorStyle,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                      width: screenWidth * 0.5,
                                      child: const Text(
                                        'We will send you one time password  (OTP)',
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.42,
                        bottom: 230,
                        child: Container(
                          height: 70,
                          width: 70,
                          color: Colors.transparent,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(80, 80),
                              backgroundColor: primaryColor,
                              shape: const CircleBorder(),
                            ),
                            onPressed: controller.verifyPhoneNumber,
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Positioned(
                        left: screenWidth * 0.12,
                        right: screenWidth * 0.12,
                        bottom: 80,
                        child: GestureDetector(
                          onTap: () {
                            AppWidgets.getToast(message: 'Feature coming soon.', color: greenTextColor);
                          },
                          child: Container(
                            height: 60,
                            width: 280,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  googleIcon,
                                  height: 30,
                                  width: 40,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                const Text(
                                  'Sign In with Google',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginBackground() {
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.5,
            color: appColor2,
          ),
          SizedBox(
              height: screenHeight * 0.5,
              width: screenWidth,
              child: Image.network(
                'https://i.pinimg.com/736x/f3/92/36/f39236b33a8c21d6dd704299af0146b7.jpg',
                fit: BoxFit.fitWidth,
              )),
          // CustomPaint(
          //   painter: TrianglePainter(
          //     strokeColor: primaryColor,
          //     strokeWidth: 1,
          //     paintingStyle: PaintingStyle.fill,
          //   ),
          //   child: SizedBox(
          //     height: screenHeight * 0.6,
          //     width: screenWidth,
          //   ),
          // )
        ],
      ),
    );
  }
}
