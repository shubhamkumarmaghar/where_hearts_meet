import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

final screenHeight = Get.height;
final screenWidth = Get.width;

SizedBox heightPercentageSpace({required double percentage}) {
  return SizedBox(
    height: screenHeight * percentage,
  );
}

SizedBox widthPercentageSpace({required double percentage}) {
  return SizedBox(
    width: screenWidth * percentage,
  );
}

SizedBox heightSpace(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox widthSpace(double width) {
  return SizedBox(
    width: width,
  );
}
