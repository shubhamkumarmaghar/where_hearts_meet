import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;

  const BaseContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: Get.isDarkMode
          ? const BoxDecoration(
              color: Colors.white,
            )
          : const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/images/app_background.png"),
                fit: BoxFit.cover,
              ),
            ),
      child: child /* add child content here */,
    );
  }
}
