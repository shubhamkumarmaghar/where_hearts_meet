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
          gradient:LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff9467ff),
                Color(0xffae8bff),
                Color(0xffc7afff),
                Color(0xffdfd2ff),
                Color(0xfff2edff),
              ]
          )
            ),
      child: child /* add child content here */,
    );
  }
}
