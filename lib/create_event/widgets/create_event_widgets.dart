import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';
import 'package:where_hearts_meet/utils/widgets/outlined_busy_button.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/model/event_type_model.dart';

Future<String?> showTextDialog({required String dialogTitle, required String hintText}) async {
  final TextEditingController textController = TextEditingController();

  return showDialog<String>(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(dialogTitle,
            style: GoogleFonts.dangrek(
                decoration: TextDecoration.none, color: primaryColor, fontWeight: FontWeight.w500, fontSize: 22)),
        content: TextField(
          controller: textController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey.shade500),
          ),
        ),
        actions: [
          Row(
            children: [
              OutlinedBusyButton(
                height: screenHeight*0.04,
                width: screenWidth*0.3,
                titleTextStyle: TextStyle(fontSize: 14,color: primaryColor,fontWeight: FontWeight.w500),
                buttonCorner: 15,

                title: 'Cancel',
                onPressed: () => Get.back() ,
              ),
              SizedBox(width: screenWidth*0.02,),
              GradientButton(
                height: screenHeight*0.04,
                width: screenWidth*0.3,
                titleTextStyle: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500),
                title: 'Submit',
                buttonCorner: 15,
                onPressed: () => Get.back(result: textController.text),

              ),
            ],
          ),

        ],
      );
    },
  );
}

Future<EventTypeModel?> showEventsTypeBottomSheet() {
  return showModalBottomSheet<EventTypeModel>(
    context: Get.context!,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Container(
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          height: Get.height * 0.7,
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Select Event Type',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: screenHeight * 0.62,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var data = getEventsTypeList()[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop(data);
                        },
                        child: SizedBox(
                          height: screenHeight * 0.04,
                          child: Row(
                            children: [
                              Icon(
                                data.eventIcon,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: screenWidth * 0.03,
                              ),
                              Text(
                                data.eventName ?? '',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: primaryColor),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: getEventsTypeList().length),
              ),
            ],
          ));
    },
  );
}

enum EventImageType { coverImage, displayImage, backgroundImage }
