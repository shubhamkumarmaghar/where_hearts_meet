import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../consts/app_screen_size.dart';
import '../../consts/color_const.dart';

class AppWidgets {
  static void getToast({required String message, Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget getLoader({Color? color}) {
    return Center(
      child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(color ?? primaryColor)),
    );
  }

  static Widget noData({
     String? message,
  }) {
    return Center(
      child: Text(
        message ?? 'No Data found!',
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey),
      ),
    );
  }
  static void showSnackBar({required BuildContext context, String? message,Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ??'Something went wrong!'),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: color ?? errorColor,
      ),
    );
  }
  static void getErrorSnackbar(String body) {
    Get.snackbar(
      'Error !',
      body,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: errorColor,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      margin: EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 1,
      ),
      icon: Icon(
        Icons.error,
        size: 4,
        color: Colors.white,
      ),
    );
  }

  void showProgressLoader(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          backgroundColor: Colors.white,
          elevation: 2.0,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            constraints: BoxConstraints(
              maxHeight: 200.0,
              maxWidth: screenWidth * 0.3,
            ),
            child: const SizedBox(
              height: 24.0,
              width: 24.0,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
    );
  }

  void cancelLoader() {
    Get.back();
  }
}
