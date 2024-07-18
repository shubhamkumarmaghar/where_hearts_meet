import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';

import '../consts/color_const.dart';
import '../consts/widget_styles.dart';

class DesignerTextField extends StatelessWidget {
  DesignerTextField({super.key, this.hint,
    this.inputAction,
    this.onTap,
    this.inputType = TextInputType.text,
    this.error,
    required this.onChanged,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign,
    required this.controller,
    this.maxLines,
    this.suffix,
    this.borderColor,
    this.cornerRadius,
    this.title});

  final Function(String) onChanged;
  final Function? onTap;
  final String? hint;
  final String? title;
  final int? maxLines;
  final Widget? suffix;
  Color? borderColor;
  double? cornerRadius;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? error;
  final bool? obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            '$title',
            style: headingStyle(fontSize: 18),
          ),
         SizedBox(
          height: screenHeight*0.01,
        ),
        GestureDetector(
          onTap: () {
            onTap != null ? onTap!() : () {};
          },
          child: TextFormField(
            enabled: enabled,
            controller: controller,
            keyboardType: inputType,
            textAlign: textAlign == null ? TextAlign.start : textAlign!,
            textInputAction: inputAction,
            maxLines: maxLines == null || maxLines == 0 ? 1 : maxLines,
            style:  TextStyle(color:enabled? blackColor:greyColor, fontSize: 14.0, fontWeight: FontWeight.w600),
            onChanged: onChanged,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0,vertical: maxLines != null && maxLines! > 2 ? 10:1),
              border: BorderStyles.auctionTextFieldBorderStyle,
              enabledBorder: cornerRadius == null ? BorderStyles.auctionTextFieldBorderStyle : BorderStyles
                  .auctionTextFieldBorderStyleCustom(cornerRadius: cornerRadius!, color: borderColor),
              disabledBorder: BorderStyles.auctionTextFieldBorderStyle,
              focusedBorder: BorderStyles.auctionTextFieldBorderStyleCustom(cornerRadius: cornerRadius ?? 50),
              errorText: error,
              errorMaxLines: 3,
              errorBorder: BorderStyles.errorBorder,
              suffix: suffix,
              errorStyle: TextStyles.errorStyle,
              hintStyle: TextStyles.hintStyle,
              filled: true,
              hintText: hint,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}