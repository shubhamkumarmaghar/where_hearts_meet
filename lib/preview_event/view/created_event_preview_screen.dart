import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/preview_event/controller/created_event_preview_controller.dart';
import 'package:heart_e_homies/utils/widgets/app_bar_widget.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/designer_text_field.dart';

class CreatedEventPreviewScreen extends StatelessWidget {
  const CreatedEventPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatedEventPreviewController>(
      init: CreatedEventPreviewController(),
      builder: (controller) {
        final data = controller.eventResponseModel;
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            toolbarHeight: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(gradient: backgroundGradient),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Align(alignment: Alignment.centerLeft, child: backIcon()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${StringConsts.eventType}*',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: screenWidth,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: greyColor, width: 0.0)),
                          height: Get.height * 0.06,
                          child: Text(
                            data.eventType ?? '',
                            style: TextStyle(color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: '${StringConsts.eventName}*',
                            hint: StringConsts.enterEventName,
                            onChanged: (text) {},
                            enabled: false,
                            maxLength: 30,
                            controller: controller.eventNameController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: '${StringConsts.personName}*',
                            hint: StringConsts.enterName,
                            onChanged: (text) {},
                            enabled: false,
                            maxLength: 30,
                            controller: controller.nameController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: '${StringConsts.personMobileNumber}*',
                            hint: StringConsts.enterMobileNumber,
                            inputType: TextInputType.phone,
                            maxLength: 10,
                            enabled: false,
                            onChanged: (text) {},
                            controller: controller.personMobileController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        DesignerTextField(
                            title: StringConsts.description,
                            hint: StringConsts.saySomethingAboutEvent,
                            maxLines: 5,
                            cornerRadius: 15,
                            enabled: false,
                            inputType: TextInputType.text,
                            onChanged: (text) {},
                            controller: controller.descriptionController),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${StringConsts.eventDay}*',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: screenWidth,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: greyColor, width: 0.0)),
                          height: Get.height * 0.06,
                          child: Text(
                            getYearTime(data.eventHostDay ?? ''),
                            style: TextStyle(color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${StringConsts.coverImage}*',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          height: screenHeight * 0.24,
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: cachedImage(imageUrl: data.coverImage),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${StringConsts.backgroundImage}*',
                            style: textStyleDangrek(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          height: screenHeight * 0.24,
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: cachedImage(imageUrl: data.splashBackgroundImage),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
