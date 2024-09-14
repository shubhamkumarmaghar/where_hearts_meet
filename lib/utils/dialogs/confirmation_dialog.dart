import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../widgets/gradient_button.dart';
import '../widgets/outlined_busy_button.dart';

void showConfirmationBottomSheet(
    {required BuildContext context,
    String? description,
    String? text,
    Color? color,
    IconData? iconData,
    double? fontSize,
    required Function() onTapYes}) {
  showAdaptiveDialog(
    context: context,
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    // ),
    builder: (context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: errorColor, width: 3)),
              padding: EdgeInsets.all(10),
              child: Icon(
                iconData ?? Icons.add,
                size: 30,
                color: errorColor,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Visibility(
              visible: text != null && text.isNotEmpty,
              child: Text(
                text ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            Text(
              description ?? '',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                  color: color ?? blackColor.withOpacity(0.5), fontSize: fontSize ?? 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.05,
                    child: GradientButton(
                      title: 'Yes',
                      onPressed: onTapYes,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth*0.04,
                ),
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.05,
                    child: OutlinedBusyButton(
                      title: 'No',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
