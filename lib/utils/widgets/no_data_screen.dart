import 'dart:developer';

import 'package:flutter/material.dart';

import '../consts/app_screen_size.dart';
import '../util_functions/decoration_functions.dart';
import 'app_bar_widget.dart';

class NoDataScreen extends StatelessWidget {
  final String? message;
  final bool showBackIcon;

  const NoDataScreen({super.key, this.message, this.showBackIcon = false});

  @override
  Widget build(BuildContext context) {
    log('this');
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
