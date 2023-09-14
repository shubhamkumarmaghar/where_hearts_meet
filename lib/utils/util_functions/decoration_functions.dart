import 'package:flutter/material.dart';

Color getColorBasedOnIndex(int index) {
  int temp = index % 6;
  if (index >= 6) {
    temp = index % 6;
  } else {
    temp = index;
  }
  switch (temp) {
    case 0:
      return const Color(0XFF0089C6);
    case 1:
      return const Color(0XFF80A93F);
    case 2:
      return const Color(0XFFDF7927);
    case 3:
      return const Color(0XFFDF317A);
    case 4:
      return const Color(0XFF24B856);
    case 5:
      return const Color(0XFFFCAE1A);
    default:
      return Colors.purple;
  }
}