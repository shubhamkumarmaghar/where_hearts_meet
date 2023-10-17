import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/controller/profile_setup_controller.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/widgets/base_container.dart';
import '../../utils/widgets/gradient_button.dart';
import '../profile_setup_const.dart';

class ProfileSetupScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<ProfileSetupController>();

  ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileSetupController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    Text(
                      '0${controller.pageIndex} ',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: primaryColor),
                    ),
                    const Text(
                      '/03',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: blackColor),
                    ),
                  ],
                ),
              ),
            ],
            title: Container(
              width: 130,
              height: 7,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: controller.pageIndex / 3,
                  color: primaryColor,
                  backgroundColor: whiteColor,
                ),
              ),
            ),
            leading: Container(
              child: GestureDetector(
                onTap: () {
                  controller.onBack();
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: blackColor,
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: whiteColor,
          body: BaseContainer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: controller.getPage(),
            ),
          ),
          bottomNavigationBar: Container(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 24.0, top: 8.0),
              child: GradientButton(
                title: 'Continue',
                enabled: true,
                height: _mainHeight * 0.06,
                width: _mainWidth * 0.8,
                onPressed: () {
                  controller.onNext();
                },
              )),
        );
      },
    );
  }
}
