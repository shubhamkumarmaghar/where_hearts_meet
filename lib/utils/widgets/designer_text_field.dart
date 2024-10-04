import 'package:flutter/material.dart';

import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/widget_styles.dart';
import '../util_functions/decoration_functions.dart';

class DesignerTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function? onTap;
  final String? hint;
  final String? title;
  final int? maxLines;
  final int? minLines;
  final Widget? suffix;
  final FocusNode? focusNode;
  final Color? borderColor;
  final double? cornerRadius;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? error;
  final bool? obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final int? maxLength;
  final Widget? suffixIcon;
  final TextStyle? titleTextStyle;
  final TextAlign? textAlign;
  final TextEditingController? controller;

  DesignerTextField(
      {super.key,
      this.hint,
      this.inputAction,
      this.onTap,
      this.maxLength,
        this.minLines,
      this.focusNode,
      this.titleTextStyle,
      this.inputType = TextInputType.text,
      this.error,
      required this.onChanged,
      this.obscureText = false,
      this.enabled = true,
      this.prefixIcon,
      this.suffixIcon,
      this.textAlign,
      this.controller,
      this.maxLines,
      this.suffix,
      this.borderColor,
      this.cornerRadius,
      this.title});

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
            style: titleTextStyle ?? textStyleDangrek(fontSize: 18),
          ),
        SizedBox(
          height: screenHeight * 0.005,
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
            minLines: minLines,
            maxLength: maxLength,
            style: TextStyle(color: enabled ? blackColor : greyColor, fontSize: 14.0, fontWeight: FontWeight.w600),
            onChanged: onChanged,
            focusNode: focusNode,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              counterText: '',
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: maxLines != null && maxLines! > 2 ? 10 : 1),
              border: BorderStyles.auctionTextFieldBorderStyle,
              enabledBorder: cornerRadius == null
                  ? BorderStyles.auctionTextFieldBorderStyle
                  : BorderStyles.auctionTextFieldBorderStyleCustom(
                      cornerRadius: cornerRadius ?? 50, color: borderColor),
              disabledBorder: BorderStyles.auctionTextFieldBorderStyleCustom(
                  cornerRadius: cornerRadius ?? 50, color: borderColor),
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
