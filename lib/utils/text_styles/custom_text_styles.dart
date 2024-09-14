import 'package:flutter/material.dart';

import '../consts/color_const.dart';

Text getPrimaryText({required String text, double? fontSize, FontWeight? fontWeight, Color? textColor}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize ?? 16, fontWeight: fontWeight ?? FontWeight.w500, color: textColor ?? primaryColor),
  );
}
