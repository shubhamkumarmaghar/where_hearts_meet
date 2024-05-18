import 'package:flutter/material.dart';

import '../consts/color_const.dart';

class GradientButton extends StatefulWidget {
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
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: widget.enabled
          ? BoxDecoration(
              color: widget.buttonColor,
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
              borderRadius: BorderRadius.circular(widget.buttonCorner ?? 50.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(widget.width, 50)),
          backgroundColor: widget.enabled
              ? MaterialStateProperty.all(widget.buttonColor)
              : MaterialStateProperty.all(greyColor),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: widget.busy || widget.enabled == false ? () {} : widget.onPressed,
        child: widget.busy
            ? const SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                widget.title,
                style: widget.titleTextStyle ??
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),
              ),
      ),
    );
  }
}
