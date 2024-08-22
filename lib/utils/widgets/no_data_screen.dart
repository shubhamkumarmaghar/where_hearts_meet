import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';

class NoDataScreen extends StatelessWidget {
  final String? message;
  final bool showBackIcon;

  const NoDataScreen({super.key, this.message, this.showBackIcon = false});

  @override
  Widget build(BuildContext context) {
    return showBackIcon
        ? SizedBox(
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                backIcon(),
                const Spacer(),
                Center(
                  child: Text(
                    message ?? 'No Data found!.',
                    textAlign: TextAlign.center,
                    style: textStyleDangrek(),
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        : Center(
            child: Text(
              message ?? 'No Data found!.',
              textAlign: TextAlign.center,
              style: textStyleDangrek(),
            ),
          );
  }
}
