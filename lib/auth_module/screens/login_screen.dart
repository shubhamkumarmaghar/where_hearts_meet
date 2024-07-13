import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/controller/login_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/widget_styles.dart';
import '../../utils/widgets/triangle_custom_painter.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.find<LoginController>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/736x/f3/92/36/f39236b33a8c21d6dd704299af0146b7.jpg',
            ),
            fit: BoxFit.cover,
          )),
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight*0.15,
                ),
                Image.asset(
                  logo,
                  height: screenHeight*0.2,
                  width: screenWidth*0.4,
                ),
                Container(
                  height: screenHeight*0.4,
                  margin: EdgeInsets.only(left: screenWidth * 0.07, right: screenWidth * 0.07),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade200
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
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
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
                            ),
                            Text(
                              'India',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
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
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
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
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                          )),
                       SizedBox(
                        height: screenHeight*0.05,
                      ),
                      InkWell(
                        onTap: controller.verifyPhoneNumber,
                        child: Container(
                          height: 55,
                          width: screenWidth*0.7,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [

                              BoxShadow(
                                color: primaryColor.withOpacity(0.8),
                                offset: Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              ),
                            ],
                          ),
                          child: Text('Submit',style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight*0.12,
                ),
                GestureDetector(
                  onTap: () {
                    AppWidgets.getToast(message: 'Feature coming soon.', color: greenTextColor);
                  },
                  child: Container(
                    height: 55,
                    width: 280,
                    decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey.shade200),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          offset: Offset(-6.0, -6.0),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(6.0, 6.0),
                          blurRadius: 16.0,
                        ),
                      ],
                    ),
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
    );
  }

  Widget getLoginBackground() {
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Image.network(
        'https://i.pinimg.com/736x/f3/92/36/f39236b33a8c21d6dd704299af0146b7.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
