import 'package:flutter/cupertino.dart';
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
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator.adaptive(

        ),
        const SizedBox(width: 15,),
        Text(
          loadingText ?? 'Loading...',
          style: const TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.w500),
        ),
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

void cancelDialog() => Get.back();

void showAlertDialogWithOK({String? message, required BuildContext context, Function? onCLick}) {
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text(
      message ?? 'Are you sure?',
      style: const TextStyle(fontSize: 16),
    ),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('Ok', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () {
          onCLick != null ? onCLick() : cancelDialog();
        },
      ),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showLogoutAlertDialog({String? message, required BuildContext context,required Function logOutFunction}) {
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Center(child: Text(message ?? 'Are you sure to exit?', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400))),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('Yes', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () async {
          await logOutFunction();
        },
      ),
      CupertinoDialogAction(
        isDefaultAction: false,
        child: const Text('No', style: TextStyle(fontSize: 16, color: primaryColor)),
        onPressed: () {
          cancelDialog();
        },
      ),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

