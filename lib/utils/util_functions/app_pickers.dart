
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';

Future<DateTime?> dateOfBirthPicker({required BuildContext context}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2028),
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

  if (picked != null ) {
    return picked;
  }
  return null;
}