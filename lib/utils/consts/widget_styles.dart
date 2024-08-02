import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

class TextStyles {
  TextStyles();

  static TextStyle appBar = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    color: Colors.black,
  );

  static TextStyle errorStyle = const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0, color: Colors.red);

  static TextStyle hintStyle =  TextStyle(color: Colors.grey.shade400, fontSize: 14.0, fontWeight: FontWeight.w500);
}

class BorderStyles {
  static const OutlineInputBorder textFieldBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50.0),
    ),
    borderSide: BorderSide(
      color: Colors.grey,
      width: 0.0,
    ),
  );

  static const OutlineInputBorder auctionTextFieldBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50.0),
    ),
    borderSide: BorderSide(
      color: greyColor,
      width: 0.0,
    ),
  );

  static OutlineInputBorder auctionTextFieldBorderStyleCustom({required double cornerRadius, Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(cornerRadius),
      ),
      borderSide: BorderSide(
        color: color ?? Colors.grey,
        width: 0.0,
      ),
    );
  }

  static const OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50.0),
    ),
    borderSide: BorderSide(
      color: Colors.red,
      width: 0.5,
    ),
  );
}
