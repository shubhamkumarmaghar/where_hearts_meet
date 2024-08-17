import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;

  const BaseContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height, decoration: BoxDecoration(color: Colors.white, gradient: backgroundGradient), child: child);
  }
}
