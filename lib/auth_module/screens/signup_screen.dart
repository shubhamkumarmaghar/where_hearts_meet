import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/routes/app_routes.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/routes/routes_const.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/gradient_text.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<SignUpController>();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BaseContainer(
          child: Container(
            height: _mainHeight,
            width: _mainWidth,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome to  ',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                      GradientText(
                        text: 'WHM',
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade400,
                            Colors.blue.shade400,
                            primaryColor,
                            primaryColor,
                            Colors.yellow.shade600,
                            const Color(0XFF7AB02A),
                          ],
                        ),
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create Account  ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: _mainWidth * 0.06, right: _mainWidth * 0.06),
                    width: _mainWidth,
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: _mainHeight * 0.03),
                      child: Column(
                        children: [
                          Obx(
                            () => CustomTextField(
                                title: 'Email',
                                error: controller.errorEmailText.value,
                                hint: 'Please enter email',
                                onChanged: controller.onEmailChanged,
                                controller: controller.emailTextController),
                          ),
                          SizedBox(
                            height: _mainHeight * 0.02,
                          ),
                          Obx(
                            () => CustomTextField(
                              title: 'UserName',
                              error: controller.errorUserNameText.value,
                              hint: 'Please enter Username',
                              onChanged: controller.onUsernameChanged,
                              controller: controller.usernameTextController,
                            ),
                          ),
                          SizedBox(
                            height: _mainHeight * 0.02,
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
                                onTap: () => controller.obscurePassword.value = !controller.obscurePassword.value,
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
                          Obx(
                            () => CustomTextField(
                              title: 'Confirm Password',
                              error: controller.errorConfirmPasswordText.value,
                              hint: 'Please enter confirm password',
                              obscureText: controller.obscurePassword.value,
                              onChanged: controller.onConfirmPasswordChanged,
                              controller: controller.confirmPasswordTextController,
                              suffix: InkWell(
                                onTap: () =>
                                    controller.obscureConfirmPassword.value = !controller.obscureConfirmPassword.value,
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
                            height: _mainHeight * 0.06,
                          ),
                         Obx(() {
                           return  Center(
                             child: GradientButton(
                               title: 'Register',
                               height: _mainHeight * 0.06,
                               width: _mainWidth * 0.8,
                               enabled: controller.enableSignUpButton.value,
                               onPressed: () async {
                                 controller.createUserWithEmail();
                               },
                             ),
                           );
                         }),
                          SizedBox(
                            height: _mainHeight * 0.025,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(RoutesConst.loginScreen);
                            },
                            child: Container(
                              color: whiteColor,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account ?  ',
                                      style: TextStyle(
                                        color: blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      )),
                                  Text(
                                    'Login',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
