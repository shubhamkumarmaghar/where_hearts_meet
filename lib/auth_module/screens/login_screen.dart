
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/controller/login_controller.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_text.dart';
import 'package:where_hearts_meet/utils/widgets/triangle_custom_painter.dart';

import '../../utils/consts/color_const.dart';
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
          child: Container(
            height: _mainHeight,
            width: _mainWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: _mainHeight,
                    child: Stack(
                      children: [
                       getLoginBackground(),
                        Positioned(
                          top: _mainWidth*0.63,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: _mainHeight * 0.5,
                            margin: EdgeInsets.only(left: _mainWidth*0.06, right: _mainWidth*0.06),
                            width: _mainWidth,
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  color: whiteColor,
                                  lightSource: LightSource.top,
                                boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),

                                )),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 15,right: 15,top: 30),
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
                                    SizedBox(height: _mainHeight*0.02,),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child: const Text('Forgot Password ?',style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            decoration: TextDecoration.underline
                                        ),)),
                                    SizedBox(height: _mainHeight*0.06,),
                                    Center(
                                      child: GradientButton(
                                        title: 'Login',
                                        height: _mainHeight*0.06,
                                        width: _mainWidth*0.8,
                                        onPressed: () {
                                          Get.toNamed(RoutesConst.dashboardScreen);
                                        },),
                                    ),
                                    SizedBox(height: _mainHeight*0.025,),
                                    GestureDetector(
                                      onTap: (){
                                        Get.toNamed(RoutesConst.signUpScreen);
                                      },
                                      child: Container(
                                        color: whiteColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text('Don\'t have an account ?  ',style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,


                                            )),
                                            Text('Create one',style: TextStyle(
                                              color: primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                decoration: TextDecoration.underline

                                            ),),
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
                        ),
                        Positioned(
                            top: _mainHeight*0.13,
                            left: _mainWidth*0.06,
                            child: const Text('Welcome  back',style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w700

                            ),)),
                        Positioned(
                            top: _mainHeight*0.18,
                            left: _mainWidth*0.06,
                            child: Row(
                              children: [
                                const Text('to  ',style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w700

                                ),),
                                GradientText(text: 'WHM', gradient: LinearGradient(
                                  colors: [
                                    Colors.red.shade400,
                                    Colors.blue.shade400,
                                    primaryColor,
                                    primaryColor,
                                    Colors.yellow.shade600,
                                    const Color(0XFF7AB02A),
                                  ],

                                ),style: const TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w700
                                ),),
                                const GradientText(text: '  \u2764 ', gradient: LinearGradient(
                                  colors: [
                                    redColorDefault,
                                    redColorDefault,
                                  ],

                                ),style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700
                                ),)
                              ],
                            )),


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
