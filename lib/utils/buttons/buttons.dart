import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../util_functions/decoration_functions.dart';

Widget getElevatedButton(
    {required Widget child,
    required Function onPressed,
    double? height,
    double? width,
    Color? buttonColor,
    double? borderRadius}) {
  return InkWell(
    onTap: () async {
      await onPressed();
    },
    child: Container(
      height: height ?? 50,
      width: width ?? 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: buttonColor ?? primaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15))),
      child: child,
    ),
  );
}

Widget getIconButton({required Icon child, required Function onPressed, double? height, double? width}) {
  return InkWell(
    onTap: () async {
      await onPressed();
    },
    child: Container(
      height: height ?? 50,
      width: width ?? 100,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(100)), color: blackColor),
      child: child,
    ),
  );
}

Widget getOutlinedButton(
    {required Widget child,
    required Function onPressed,
    double? height,
    double? width,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius}) {
  return InkWell(
    onTap: () async {
      await onPressed();
    },
    child: Container(
      height: height ?? 50,
      width: width ?? 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor ?? primaryColor, width: borderWidth ?? 1),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 50))),
      child: child,
    ),
  );
}

