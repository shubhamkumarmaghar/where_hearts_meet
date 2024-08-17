import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';

Widget showProfileCompletionPercentage({required int completed}) {
  final percentage = (completed / 100);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Profile completed ($completed % )',
        style: textStyleAleo(fontSize: 18),
      ),
      SizedBox(
        height: screenHeight * 0.01,
      ),
      SizedBox(
        width: screenWidth * 0.8,
        child: LinearProgressIndicator(
          value: percentage,
          borderRadius: BorderRadius.circular(5),
          backgroundColor: Colors.grey[600],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          minHeight: 8,
        ),
      ),
    ],
  );
}
