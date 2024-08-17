import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
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
          title: 'Submit',
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
              //color: appColor1,
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
                    'Schedule Event',
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
                              title: 'Person Name*',
                              hint: 'Enter name',
                              onChanged: (text) {},
                              controller: controller.nameController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          DesignerTextField(
                              title: 'Event Name*',
                              hint: 'Enter event name',
                              onChanged: (text) {},
                              controller: controller.eventNameController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          DesignerTextField(
                              title: "Person's mobile number*",
                              hint: 'Mobile number',
                              inputType: TextInputType.phone,
                              maxLength: 10,
                              onChanged: (text) {},
                              controller: controller.personMobileController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          DesignerTextField(
                              title: "Description",
                              maxLines: 5,
                              cornerRadius: 15,
                              hint: 'Say something about him/her',
                              inputType: TextInputType.text,
                              onChanged: (text) {},
                              controller: controller.descriptionController),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Event Type*',
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
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
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
                              'Upload cover image*',
                              style: textStyleDangrek(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              showImagePickerDialog(
                                context: Get.context!,
                                onCamera: () => controller.onCaptureMediaClick(
                                    source: ImageSource.camera, imageType: EventImageType.coverImage),
                                onGallery: () => controller.onCaptureMediaClick(
                                    source: ImageSource.gallery, imageType: EventImageType.coverImage),
                              );
                            },
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
