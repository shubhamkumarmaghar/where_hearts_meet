import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/designer_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/create_event_controller.dart';
import '../widgets/create_event_widgets.dart';

class CreateEventScreen extends StatelessWidget {
  final controller = Get.find<CreateEventController>();

  CreateEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: appColor3,
        padding: EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth * 0.08, bottom: screenHeight * 0.02),
        child: GradientButton(
          title: StringConsts.submit,
          buttonCorner: 20,
          height: screenHeight * 0.06,
          buttonColor: appColor1,
          width: screenWidth * 0.8,
          onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            controller.navigateToCreateEventSplashScreen();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: GetBuilder<CreateEventController>(
          builder: (controller) {
            return Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(gradient: backgroundGradient),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  appHeader,
                  Text(
                    StringConsts.scheduleEvent,
                    style: textStyleDangrek(fontSize: 24),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          DesignerTextField(
                              title: '${StringConsts.personName}* (Max 30 words)',
                              hint: StringConsts.enterName,
                              onChanged: (text) {},
                              maxLength: 30,
                              controller: controller.nameController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          DesignerTextField(
                              title: '${StringConsts.eventName}* (Max 30 words)',
                              hint: StringConsts.enterEventName,
                              onChanged: (text) {},
                              maxLength: 30,
                              controller: controller.eventNameController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          DesignerTextField(
                              title: '${StringConsts.personMobileNumber}*',
                              hint: StringConsts.enterMobileNumber,
                              inputType: TextInputType.phone,
                              maxLength: 10,
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
                              inputType: TextInputType.text,
                              onChanged: (text) {},
                              controller: controller.descriptionController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${StringConsts.selectEventType}*',
                              style: textStyleDangrek(fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () {
                              controller.selectEventSheet();
                            },
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: greyColor, width: 0.0)),
                              height: Get.height * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Text(
                                    controller.selectedEventType.eventName ?? '',
                                    style: TextStyle(
                                        color:controller.selectedEventType.eventName == StringConsts.eventName ?Colors.grey.shade400:blackColor, fontSize: 14.0, fontWeight: FontWeight.w600),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_drop_down),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${StringConsts.uploadCoverImage}*',
                              style: textStyleDangrek(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          InkWell(
                            onTap: () => controller.selectImage(EventImageType.coverImage),
                            child: controller.coverImage != null && controller.coverImage!.isNotEmpty
                                ? ClayContainer(
                                    height: screenHeight * 0.24,
                                    width: screenWidth * 0.85,
                                    borderRadius: 20,
                                    color: appColor2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        controller.coverImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                : ClayContainer(
                                    height: screenHeight * 0.12,
                                    width: screenWidth * 0.3,
                                    borderRadius: 20,
                                    color: appColor2,
                                    child: Icon(
                                      Icons.upload,
                                      size: screenHeight * 0.06,
                                      color: Colors.white,
                                    )),
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
            );
          },
        ),
      ),
    );
  }
}
