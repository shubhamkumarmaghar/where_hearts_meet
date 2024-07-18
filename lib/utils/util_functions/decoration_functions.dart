import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/images_const.dart';

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

LinearGradient get backgroundGradient {
  return const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
    primaryColor,
    appColor1,
    appColor2,
    appColor3,
  ]);
}

Widget get appHeader {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: screenHeight * 0.08,
        child: Image.asset(
          logo,
        ),
      ),
      SizedBox(
        width: screenWidth * 0.01,
      ),
      Text(
        'Heart-e-homies',
        style: GoogleFonts.aclonica(
            decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
      ),
    ],
  );
}
String getYearTime(String date) {
  if (date.isEmpty) {
    return '';
  }
  final dateTime = DateTime.parse(date);
  final time = '${addZero(dateTime.day)}/${addZero(dateTime.month)}/${dateTime.year}';
  return time;
}

String addZero(int value) {
  return value > 9 ? value.toString() : '0$value';
}

TextStyle headingStyle({double? fontSize, Color? color, FontWeight? fontWeight}) {
  return GoogleFonts.dangrek(
      color: color ?? Colors.white, fontWeight: fontWeight ?? FontWeight.w500, fontSize: fontSize ?? 22);
}

TextStyle textStyleAbel({double? fontSize, Color? color, FontWeight? fontWeight}) {
  return GoogleFonts.abel(
      color: color ?? Colors.white, fontWeight: fontWeight ?? FontWeight.w500, fontSize: fontSize ?? 22);
}

Future<File?> cropImage({required String filePath, bool? isProfileImage}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    cropStyle: isProfileImage != null && isProfileImage ? CropStyle.circle : CropStyle.rectangle,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
      IOSUiSettings(
        title: 'Cropper',
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: true,
      ),
    ],
  );

  if (croppedImage != null) {
    return File(croppedImage.path);
  }

  return null;
}
