import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/consts/string_consts.dart';
import 'package:heart_e_homies/utils/util_functions/decoration_functions.dart';
import 'package:heart_e_homies/utils/widgets/gradient_button.dart';
import '../../utils/consts/api_urls.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/widget_styles.dart';
import '../../utils/widgets/util_widgets/app_webview.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.find<LoginController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: screenHeight * 0.35,
                  width: screenWidth,
                  padding: const EdgeInsets.all(60),
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Image.asset(
                    logo,
                    //color: Colors.white,
                    fit: BoxFit.scaleDown,
                  )),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: primaryColor.withOpacity(0.5))),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.onChangeUserType(true);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
                          decoration: BoxDecoration(
                              color: controller.registeredSelected.value ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            StringConsts.registeredUser,
                            style: textStyleAleo(
                                fontSize: 16, color: controller.registeredSelected.value ? whiteColor : primaryColor),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.onChangeUserType(false);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
                          decoration: BoxDecoration(
                              color: !controller.registeredSelected.value ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            StringConsts.guestUser,
                            style: textStyleAleo(
                                fontSize: 16, color: !controller.registeredSelected.value ? whiteColor : primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                  onChanged: controller.onPhoneNumberChanged,
                  controller: controller.phoneNumberController,
                  decoration: InputDecoration(
                    //errorText: controller.errorPhoneNumberText.value,
                    hintText: StringConsts.enterMobileNumber,
                    errorMaxLines: 3,
                    hintStyle: const TextStyle(color: Colors.grey),
                    errorBorder: BorderStyles.errorBorder,
                    errorStyle: TextStyles.errorStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: screenWidth * 0.5,
                  child: const Text(
                    StringConsts.willSendOTP,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                  )),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                          value: controller.conditionsAccepted.value, onChanged: controller.onConditionsAccepted);
                    }),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: StringConsts.byClicking,
                              style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                                text: StringConsts.termsAndConditions,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => AppWebView(
                                      title: StringConsts.termsAndConditions, url: AppUrls.termsAndConditionsUrl)),
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline)),
                            const TextSpan(
                              text: ' & ',
                              style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: StringConsts.privacyPolicy,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(
                                    () => AppWebView(title: StringConsts.privacyPolicy, url: AppUrls.privacyPolicyUrl)),
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Obx(() {
                return GradientButton(
                  onPressed: controller.verifyPhoneNumber,
                  height: 50,
                  enabled: controller.showSubmitButton.value,
                  width: screenWidth * 0.8,
                  title: StringConsts.submit,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
