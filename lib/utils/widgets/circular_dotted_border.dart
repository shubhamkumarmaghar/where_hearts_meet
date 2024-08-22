import 'dart:math';

import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

class DottedCircularBorder extends StatelessWidget {
  final int totalNumber;
  final Widget widget;
  final double radius;
  final Color dotsColor;

  const DottedCircularBorder({super.key, required this.totalNumber,required this.widget,required this.radius,this.dotsColor =primaryColor});


  double colorWidth(double radius, int statusCount, double separation) {
    return ((2 * pi * radius) - (statusCount * separation)) / statusCount;
  }

  double separation(int statusCount) {
    if (statusCount <= 20) {
      return 3.0;
    } else if (statusCount <= 30) {
      return 1.8;
    } else if (statusCount <= 60) {
      return 1.0;
    } else {
      return 0.3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: dotsColor,
      borderType: BorderType.Circle,
      radius: Radius.circular(radius),
      dashPattern: totalNumber == 1
          ? [
              //one status
              (2 * pi * (radius + 2)),
              0,
            ]
          : [
              //multiple status
              colorWidth(radius + 2, totalNumber, separation(totalNumber)),
              separation(totalNumber),
            ],
      strokeWidth: 3,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        child: widget,
      ),
    );
  }
}
