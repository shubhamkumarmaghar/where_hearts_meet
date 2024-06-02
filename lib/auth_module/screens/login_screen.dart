import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 30,),
                            Container(
                              height: _mainHeight * 0.53,
                              margin: EdgeInsets.only(left: _mainWidth * 0.06, right: _mainWidth * 0.06),
                              width: _mainWidth,

                              child: Card(
                                shape:
                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => CustomTextField(
                                            title: 'Mobile Number',
                                            error: controller.errorPhoneNumberText.value,
                                            inputType: TextInputType.phone,
                                            hint: 'Please enter mobile number',
                                            onChanged: controller.onPhoneNumberChanged,
                                            controller: controller.phoneNumberController),
                                      ),
                                      SizedBox(
                                        height: _mainHeight * 0.04,
                                      ),
                                      Obx(
                                        () => CustomTextField(
                                          title: 'Password',
                                          error: controller.errorPasswordText.value,
                                          hint: 'Please enter password',
                                          obscureText: controller.obscurePassword.value,
                                          onChanged: controller.onPasswordChanged,
                                          controller: controller.passwordTextController,
                                          suffix: InkWell(
                                            onTap: () =>
                                                controller.obscurePassword.value = !controller.obscurePassword.value,
                                            child: Container(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: const Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: blackColor,
                                                  size: 15,
                                                )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: _mainHeight * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () async {},
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            child: const Text(
                                              'Forgot Password ?',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  decoration: TextDecoration.underline),
                                            )),
                                      ),
                                      SizedBox(
                                        height: _mainHeight * 0.05,
                                      ),
                                      Center(
                                        child: GradientButton(
                                          title: 'Login',
                                          height: _mainHeight * 0.06,
                                          width: _mainWidth * 0.8,
                                          onPressed: () async {
                                            controller.login();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: _mainHeight * 0.025,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.offAllNamed(RoutesConst.signUpScreen);
                                        },
                                        child: Container(
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Don\'t have an account ?  ',
                                                  style: TextStyle(
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  )),
                                              Text(
                                                'Create one',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.underline),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: _mainHeight * 0.02,
                                      ),
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
