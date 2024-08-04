import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';

import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../widgets/outlined_busy_button.dart';

void showConfirmationBottomSheet(
    {String? icon,
    required BuildContext context,
    String? description,
    String? text,
    Color? color,
    IconData? iconData,
    double? fontSize,
    required Function() onTapYes}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),

    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: screenWidth * 0.21,
            height: screenWidth * 0.21,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: errorColor,width: 5)
              ),
              child: Icon(
               iconData ?? Icons.add,
                size: 60,
                color: errorColor,
              ),
            ),
          ),
          SizedBox(height: screenHeight*0.02,),
          Visibility(
            visible: text != null && text.isNotEmpty,
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              maxLines: 2,
              style:  TextStyle(color:Colors.black , fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: screenHeight*0.01,),
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
                color: color ?? blackColor.withOpacity(0.5), fontSize: fontSize ?? 14, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: screenHeight*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.07,
                child: GradientButton(
                  title: 'Yes',
                  onPressed: onTapYes,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
                child: OutlinedBusyButton(
                  title: 'No',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
