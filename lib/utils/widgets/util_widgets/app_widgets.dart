import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import '../../consts/app_screen_size.dart';

class AppWidgets {
  static void getToast({required String message, Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? errorColor,
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
