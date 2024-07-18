import 'package:flutter/material.dart';
import '../consts/color_const.dart';

class OutlinedBusyButton extends StatelessWidget {
  final bool busy;
  final String title;
  final TextStyle? titleTextStyle;
  final Function()? onPressed;
  final bool enabled;
  final Color splashColor;
  final double width;
  final double? buttonCorner;
  final double height;
  final Color? borderColor;
  final double? borderWidth;
  final Gradient? gradient;

  const OutlinedBusyButton({
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
    this.splashColor = greyColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: enabled
                  ? BorderSide(color: borderColor ?? primaryColor, width: borderWidth ?? 1.5)
                  : const BorderSide(color: Colors.transparent, width: 0.0),
              borderRadius: BorderRadius.circular(buttonCorner ?? 50.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          backgroundColor:
              enabled ? MaterialStateProperty.all(Colors.white) : MaterialStateProperty.all(greyColor.withOpacity(0.4)),
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
                style: enabled
                    ? titleTextStyle ?? const TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: 19)
                    : const TextStyle(color: Colors.white54, fontWeight: FontWeight.w700, fontSize: 19),
              ),
      ),
    );
  }
}
