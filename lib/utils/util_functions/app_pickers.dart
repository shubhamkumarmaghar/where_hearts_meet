import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../consts/color_const.dart';
import '../dialogs/pop_up_dialogs.dart';
import '../widgets/image_dialog.dart';

Future<DateTime?> dateOfBirthPicker(
    {required BuildContext context, DateTime? initialDate}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate:
        initialDate ?? DateTime.now().subtract(const Duration(days: 365)),
    firstDate: DateTime(1950),
    lastDate: DateTime.now().subtract(const Duration(days: 365)),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: primaryColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.black, // body text color
          ),
        ),
        child: child ?? Text(''),
      );
    },
  );

  if (picked != null) {
    return picked;
  }
  return null;
}

String formatDateTime(
    {required String dateTime, String format = "dd-MMM-yyyy HH:mm:ss"}) {
  try {
    if (dateTime != "") {
      DateTime newDateTime = DateTime.parse(dateTime);
      final DateFormat formatter = DateFormat(format);
      return formatter.format(newDateTime);
    } else {
      return '00-00-0000';
    }
  } catch (e) {
    log("date erroe $e");
    return '00-00-0000';
  }
}

void showImagePickerDialog(
    {required BuildContext context,
    required Function onCamera,
    required Function onGallery,
    String? title}) async {
  await Permission.photos.request();
  await Permission.camera.request();
  await Permission.mediaLibrary.request();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.photos,
    Permission.camera,
    Permission.mediaLibrary
  ].request();

  final permission1 = statuses[Permission.camera]?.isGranted ?? false;
  final permission2 = statuses[Permission.mediaLibrary]?.isGranted ?? false;

  if (permission1 && permission2) {
    await Get.dialog(ImageDialog(
      onGalleryClicked: onGallery,
      onCameraClicked: onCamera,
      title: title,
    ));
  } else {
    showAlertDialogWithOK(context: context);
  }
}
