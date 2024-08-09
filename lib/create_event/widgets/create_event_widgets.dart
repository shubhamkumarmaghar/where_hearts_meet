import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
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
                height: screenHeight * 0.04,
                width: screenWidth * 0.3,
                titleTextStyle: TextStyle(fontSize: 14, color: primaryColor, fontWeight: FontWeight.w500),
                buttonCorner: 15,
                title: 'Cancel',
                onPressed: () => Get.back(),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              GradientButton(
                height: screenHeight * 0.04,
                width: screenWidth * 0.3,
                titleTextStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
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
  int groupValue = -1;
  EventTypeModel? eventTypeModel;
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
              color: appColor1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          height: Get.height * 0.55,
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Select Event Type',
                  style: textStyleDangrek(),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: screenHeight * 0.37,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var data = getEventsTypeList()[index];
                          return InkWell(
                            onTap: () {
                              eventTypeModel = data;
                              setState(() {
                                groupValue = index;
                              });
                            },
                            child: SizedBox(
                              height: screenHeight * 0.04,
                              child: Row(
                                children: [
                                  Icon(
                                    data.eventIcon,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Text(
                                    data.eventName ?? '',
                                    style: textStyleAleo(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Radio<int>(
                                      value: index,
                                      fillColor: MaterialStateProperty.resolveWith((states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return Colors.white;
                                        }
                                        return Colors.white;
                                      }),
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            eventTypeModel = data;
                                            groupValue = value;
                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: getEventsTypeList().length),
                  );
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ClayContainer(
                color: appColor1,
                borderRadius: 20,
                child: GradientButton(
                  title: 'Select',
                  width: screenWidth * 0.7,
                  buttonCorner: 20,
                  buttonColor: appColor1,
                  onPressed: () => Navigator.of(context).pop(eventTypeModel),
                ),
              )
            ],
          ));
    },
  );
}

enum EventImageType { coverImage, displayImage, backgroundImage }
