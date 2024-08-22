import 'package:flutter/material.dart';

import '../consts/color_const.dart';

class GradientButton extends StatelessWidget {
  final bool busy;
  final String title;
  final TextStyle? titleTextStyle;
  final Function()? onPressed;
  final bool enabled;
  final Color buttonColor;
  final Color splashColor;
  final double width;
  final double? buttonCorner;
  final double height;
  final Color? borderColor;
  final double? borderWidth;
  final Gradient? gradient;

  const GradientButton({
    super.key,
    required this.title,
    this.gradient,
    this.busy = false,
    this.titleTextStyle,
    this.onPressed,
    this.width = 150,
    this.buttonCorner,
    this.borderWidth,
    this.borderColor,
    this.height = 50,
    this.buttonColor = primaryColor,
    this.splashColor = greyColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: enabled
          ? BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(50),
            )
          : BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(50),
            ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonCorner ?? 50.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          backgroundColor: enabled ? MaterialStateProperty.all(buttonColor) : MaterialStateProperty.all(Colors.grey.shade400),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: busy || enabled == false ? () {} : onPressed,
        child: busy
            ? const SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                title,
                style:
                    titleTextStyle ?? const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),
              ),
      ),
    );
  }
}
