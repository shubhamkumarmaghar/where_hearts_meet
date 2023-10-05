import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../consts/widget_styles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hint,
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
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              '$title',
              style: const TextStyle(color: blackColor, fontSize: 18.0, fontWeight: FontWeight.w700),
            ),
          const SizedBox(
            height: 12,
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
              style: const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
              onChanged: onChanged,
              obscureText: obscureText ?? false,
              decoration: InputDecoration(
                prefixIcon: prefixIcon != null ? prefixIcon : null,
                suffixIcon: suffixIcon != null ? suffixIcon : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                border: BorderStyles.auctionTextFieldBorderStyle,
                enabledBorder: cornerRadius == null ? BorderStyles.auctionTextFieldBorderStyle : BorderStyles
                    .auctionTextFieldBorderStyleCustom(cornerRadius: cornerRadius!, color: borderColor),
                disabledBorder: BorderStyles.auctionTextFieldBorderStyle,
                focusedBorder: BorderStyles.auctionTextFieldBorderStyle,
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
      ),
    );
  }
}