import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import '../consts/app_screen_size.dart';
import '../model/dropdown_model.dart';

Future<DropDownModel?> selectDataDialog(
    {required BuildContext context,
    required String title,
    required List<DropDownModel> dataList,
    double? height}) async {
  return await showDialog<DropDownModel>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Container(
              height: height ?? screenHeight * 0.45,
              width: screenWidth * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                    child: Text(
                      title,
                      style:  textStyleDangrek(color: primaryColor,fontSize: 20),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.separated(
                      itemCount: dataList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: 0.2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        var data = dataList[index];
                        return InkWell(
                          onTap: () {
                            Get.back(result: data);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.01,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Center(
                              child: Text(
                                data.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
