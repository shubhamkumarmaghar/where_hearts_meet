import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../utils/consts/color_const.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryBackgroundColor,
      body: Container(
        child:Column(
          children: [
            Column(
              children: [
             //   CircleAvatar(child: Lottie.asset()),
                const Text(
                'Male',
                style: TextStyle(color: redColor, fontWeight: FontWeight.w700, fontSize: 24),
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
