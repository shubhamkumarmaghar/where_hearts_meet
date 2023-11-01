import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';

import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_event_controller.dart';

class AddEventScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  final controller = Get.find<AddEventController>();

  AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BaseContainer(
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
                          title: 'Name*',
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
                          title: 'Title ',
                          hint: 'Enter title text',
                          onChanged: (text) {},
                          controller: controller.titleController),
                      SizedBox(
                        height: _mainHeight * 0.03,
                      ),
                      CustomTextField(
                          title: 'Subtitle',
                          hint: 'Enter subtitle text',
                          onChanged: (text) {},
                          controller: controller.subtitleController),
                      SizedBox(
                        height: _mainHeight * 0.03,
                      ),
                      CustomTextField(
                          title: 'Info*',
                          hint: 'Enter Info',
                          onChanged: (text) {},
                          controller: controller.infoController),
                      SizedBox(
                        height: _mainHeight * 0.05,
                      ),
                      controller.screenType == ScreenName.fromDashboard ? getSelectUserView() : const SizedBox.shrink(),
                      const Text(
                        'Upload  Event  Pics*',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(
                        height: _mainHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: _mainHeight * 0.1,
                            width: _mainWidth*0.27,
                            child: controller.imageUrl1.isEmpty
                                ? NeumorphicButton(
                              onPressed: () async {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 1),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 1),
                                );
                              },
                              style: NeumorphicStyle(
                                color: greyColor.withOpacity(0.1),
                                depth: -5,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                size: _mainHeight * 0.06,
                                color: blackColor,
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 1),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 1),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    controller.imageUrl1,
                                    fit: BoxFit.fitWidth,
                                    width: _mainWidth * 0.35,
                                  )),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: _mainHeight * 0.1,
                            width: _mainWidth*0.27,
                            child: controller.imageUrl2.isEmpty
                                ? NeumorphicButton(
                              onPressed: () async {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 2),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 2),
                                );
                              },
                              style: NeumorphicStyle(
                                color: greyColor.withOpacity(0.1),
                                depth: -5,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                size: _mainHeight * 0.06,
                                color: blackColor,
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 2),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 2),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    controller.imageUrl2,
                                    fit: BoxFit.fitWidth,
                                    width: _mainWidth * 0.35,
                                  )),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: _mainHeight * 0.1,
                            width: _mainWidth*0.27,
                            child: controller.imageUrl3.isEmpty
                                ? NeumorphicButton(
                              onPressed: () async {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 3),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 3),
                                );
                              },
                              style: NeumorphicStyle(
                                color: greyColor.withOpacity(0.1),
                                depth: -5,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                size: _mainHeight * 0.06,
                                color: blackColor,
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 3),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 3),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    controller.imageUrl3,
                                    fit: BoxFit.fitWidth,
                                    width: _mainWidth * 0.35,
                                  )),
                            ),
                          ),


                        ],
                      ),
                      SizedBox(
                        height: _mainHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: _mainHeight * 0.1,
                            width: _mainWidth*0.27,
                            child: controller.imageUrl4.isEmpty
                                ? NeumorphicButton(
                              onPressed: () async {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 4),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 4),
                                );
                              },
                              style: NeumorphicStyle(
                                color: greyColor.withOpacity(0.1),
                                depth: -5,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                size: _mainHeight * 0.06,
                                color: blackColor,
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 4),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 4),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    controller.imageUrl4,
                                    fit: BoxFit.fitWidth,
                                    width: _mainWidth * 0.35,
                                  )),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: _mainHeight * 0.1,
                            width: _mainWidth*0.27,
                            child: controller.imageUrl5.isEmpty
                                ? NeumorphicButton(
                              onPressed: () async {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 5),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 5),
                                );
                              },
                              style: NeumorphicStyle(
                                color: greyColor.withOpacity(0.1),
                                depth: -5,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                size: _mainHeight * 0.06,
                                color: blackColor,
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 5),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 5),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    controller.imageUrl5,
                                    fit: BoxFit.fitWidth,
                                    width: _mainWidth * 0.35,
                                  )),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: _mainHeight * 0.1,
                            width: _mainWidth*0.27,
                            child: controller.imageUrl6.isEmpty
                                ? NeumorphicButton(
                              onPressed: () async {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 6),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 6),
                                );
                              },
                              style: NeumorphicStyle(
                                color: greyColor.withOpacity(0.1),
                                depth: -5,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              ),
                              child: Icon(
                                Icons.upload_rounded,
                                size: _mainHeight * 0.06,
                                color: blackColor,
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                showImagePickerDialog(
                                  context: Get.context!,
                                  onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera,number: 6),
                                  onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery,number: 6),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    controller.imageUrl6,
                                    fit: BoxFit.fitWidth,
                                  )),
                            ),
                          ),


                        ],
                      ),
                      SizedBox(
                        height: _mainHeight * 0.05,
                      ),
                      Center(
                        child: GradientButton(
                          title: 'Save',
                          height: _mainHeight * 0.06,
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
      ),
    );
  }

  Widget getSelectUserView() {
    return Column(
      children: [
        controller.userSelected
            ? Column(
                children: [
                  const Text(
                    'Selected  User',
                    style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor, fontSize: 22),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.02,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        controller.userSelected
            ? selectedUserView(controller: controller)
            : Center(
                child: InkWell(
                  onTap: () {
                    controller.showUsersBottomSheet();
                  },
                  child: Container(
                    height: _mainHeight * 0.06,
                    alignment: Alignment.center,
                    width: _mainWidth * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: greyColor, width: 0.5),
                        color: blackColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: const Text(
                      'Select  User',
                      style: TextStyle(color: whiteColor, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: _mainHeight * 0.05,
        ),
      ],
    );
  }

  Widget selectedUserView({required AddEventController controller}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: greyColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _mainHeight * 0.06,
                width: _mainWidth * 0.14,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: controller.selectedUser.imageUrl != null && controller.selectedUser.imageUrl != ''
                      ? Image.network(
                          controller.selectedUser.imageUrl ?? '',
                          fit: BoxFit.fill,
                        )
                      : Icon(Icons.person),
                ),
              ),
              SizedBox(
                width: _mainWidth * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.selectedUser.name ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: _mainHeight * 0.005,
                  ),
                  Text(controller.selectedUser.email ?? '',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: _mainHeight * 0.05,
        ),
        GradientButton(
          title: 'Select  Another  User',
          buttonColor: blackColor,
          enabled: true,
          height: _mainHeight * 0.06,
          width: _mainWidth * 0.67,
          onPressed: () async {
            controller.showUsersBottomSheet();
          },
        )
      ],
    );
  }
}
