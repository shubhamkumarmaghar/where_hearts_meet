import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_event_controller.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  final controller = Get.find<AddEventController>();

  AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor4,
      appBar: appBarWidget(title: 'Create Event'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: GetBuilder<AddEventController>(
          builder: (controller) {
            return Container(
              height: _mainHeight,
              width: _mainWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                    CustomTextField(
                        title: 'Person Name*',
                        hint: 'enter name',
                        onChanged: (text) {},
                        controller: controller.nameController),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),
                    CustomTextField(
                        title: 'Event Name*',
                        hint: 'Enter event name',
                        onChanged: (text) {},
                        controller: controller.eventNameController),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),

                    CustomTextField(
                        title: 'Description*',
                        hint: 'Enter Info',
                        onChanged: (text) {},
                        controller: controller.infoController),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),

                    CustomTextField(
                        title: 'Guest mobile number*',
                        hint: 'Mobile number',
                        inputType: TextInputType.phone,
                        onChanged: (text) {},
                        controller: controller.guestMobileController),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),
                    Text(
                      'Celebration Date*',
                      style: const TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey,width: 0.4)
                      ),
                      child: InkWell(
                        onTap: controller.onSelectDate,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              color: primaryColor,
                            ),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  DateFormat.yMMMd().format(controller.selectedDate.value),
                                  style:
                                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),
                    const Text(
                      'Select Event Type*',
                      style: TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        controller.selectEventSheet();
                      },
                      child: Container(
                        width: _mainWidth,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: greyColor, width: 0.0)),
                        height: Get.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(controller.selectedEventType.eventName ?? ''),
                            const Spacer(),
                            const Icon(Icons.arrow_drop_down),
                            SizedBox(
                              width: _mainWidth * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.selectedEventType.eventTypeId == '1'
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: _mainHeight * 0.03,
                              ),
                              CustomTextField(
                                  title: 'Event Type',
                                  hint: 'Enter event type',
                                  onChanged: (text) {},
                                  controller: controller.eventTypeController),
                              SizedBox(
                                height: _mainHeight * 0.03,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),
                    const Text(
                      'Event Images*',
                      style: TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(height: screenHeight * 0.1, child: getImagesListWidget(controller: controller)),

                    SizedBox(
                      height: _mainHeight * 0.1,
                    ),
                    Center(
                      child: GradientButton(
                        title: 'Create  Event',
                        height: _mainHeight * 0.06,
                        buttonColor: primaryColor,
                        width: _mainWidth * 0.8,
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await controller.addEvent();
                        },
                      ),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget getImagesListWidget({required AddEventController controller}) {
    return RawScrollbar(
      padding: const EdgeInsets.only(bottom: -7),
      radius: const Radius.circular(10),
      thumbColor: appColor4,
      thickness: 3,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.imageFiles.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: controller.imageFiles.length == index
                  ? getElevatedButton(
                onPressed: () async {
                  showImagePickerDialog(
                    context: Get.context!,
                    onCamera: () => controller.onCaptureMediaClick(
                        source: ImageSource.camera),
                    onGallery: () => controller.onCaptureMediaClick(
                        source: ImageSource.gallery),
                  );
                },
                child: Icon(
                  Icons.add_photo_alternate,
                  size: screenHeight * 0.05,
                  color: primaryColor,
                ),
              )
                  : InkWell(
                onTap: () {
                  showImagePickerDialog(
                    context: Get.context!,
                    onCamera: () => controller.onCaptureMediaClick(
                        source: ImageSource.camera),
                    onGallery: () => controller.onCaptureMediaClick(
                        source: ImageSource.gallery),
                  );
                },
                child: SizedBox(
                  width: screenWidth * 0.27,
                  height: screenHeight * 0.1,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.file(
                        controller.imageFiles[index],
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            );
          }),
    );
  }
}
