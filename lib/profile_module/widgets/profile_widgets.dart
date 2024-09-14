
import 'package:flutter/material.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';

Widget showProfileCompletionPercentage({required int completed}) {
  final percentage = (completed / 100);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile completed ($completed % )',
            style: textStyleAleo(fontSize: 18),
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Visibility(
            visible: completed == 100,
            replacement: const SizedBox.shrink(),
            child: const CircleAvatar(
              backgroundColor: greenTextColor,
              radius: 10,
              child: Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              ),
            ),
          )
        ],
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
