import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';

void showThemeDialog() {
  Get.changeThemeMode(ThemeMode.light);
}

void showSnackBar({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message ?? 'Something went wrong!'),
  ));
}

void showLoaderDialog({required BuildContext context, String? loadingText, Color? color}) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(
          color: color ?? primaryColor,
        ),
        Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              loadingText ?? 'Loading...',
              style: const TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.w500),
            )),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void cancelLoaderDialog() => Get.back();
