
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

Widget getDrawerContentWidget({required IconData icon, required String heading, required Function onTap}) {
  return InkWell(
    onTap: () => onTap(),
    child: Container(
      height: Get.height*0.05,
      color: whiteColor,
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.03,
          ),
          Container(
            height: Get.height*0.04,
            width: Get.width*0.09,
            decoration: BoxDecoration(color: appColor2.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(2),
            child: Icon(
              icon,
              color: appColor2,
              size: 20,
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Text(heading,style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: greyColor,
            size: 15,
          ),
          SizedBox(
            width: Get.width * 0.025,
          ),
        ],
      ),
    ),
  );
}
