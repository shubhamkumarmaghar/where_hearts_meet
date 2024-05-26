import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';

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
      backgroundColor: appColor5,
      appBar: appBarWidget(title: 'Add Event'),
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
                    const Text(
                      'Select Event Type*',
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: _mainHeight * 0.015,
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
                    controller.selectedEventType.eventTypeId == '4'
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
                      height: _mainHeight * 0.05,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: _mainHeight * 0.1,
                    //       width: _mainWidth * 0.27,
                    //       child: controller.imageUrl1.isEmpty
                    //           ? getElevatedButton(
                    //         onPressed: () async {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 1),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 1),
                    //           );
                    //         },
                    //         child: Icon(
                    //           Icons.add_photo_alternate,
                    //           size: _mainHeight * 0.06,
                    //           color: blackColor,
                    //         ),
                    //       )
                    //           : InkWell(
                    //         onTap: () {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 1),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 1),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           width: _mainWidth * 0.27,
                    //           height: _mainHeight * 0.1,
                    //           child: ClipRRect(
                    //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //               child: Image.network(
                    //                 controller.imageUrl1,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: _mainHeight * 0.1,
                    //       width: _mainWidth * 0.27,
                    //       child: controller.imageUrl2.isEmpty
                    //           ? getElevatedButton(
                    //         onPressed: () async {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 2),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 2),
                    //           );
                    //         },
                    //         child: Icon(
                    //           Icons.add_photo_alternate,
                    //           size: _mainHeight * 0.06,
                    //           color: blackColor,
                    //         ),
                    //       )
                    //           : InkWell(
                    //         onTap: () {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 2),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 2),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           width: _mainWidth * 0.27,
                    //           height: _mainHeight * 0.1,
                    //           child: ClipRRect(
                    //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //               child: Image.network(
                    //                 controller.imageUrl2,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: _mainHeight * 0.1,
                    //       width: _mainWidth * 0.27,
                    //       child: controller.imageUrl3.isEmpty
                    //           ? getElevatedButton(
                    //         onPressed: () async {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 3),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 3),
                    //           );
                    //         },
                    //         child: Icon(
                    //           Icons.add_photo_alternate,
                    //           size: _mainHeight * 0.06,
                    //           color: blackColor,
                    //         ),
                    //       )
                    //           : InkWell(
                    //         onTap: () {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 3),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 3),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           width: _mainWidth * 0.27,
                    //           height: _mainHeight * 0.1,
                    //           child: ClipRRect(
                    //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //               child: Image.network(
                    //                 controller.imageUrl3,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: _mainHeight * 0.03,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: _mainHeight * 0.1,
                    //       width: _mainWidth * 0.27,
                    //       child: controller.imageUrl4.isEmpty
                    //           ? getElevatedButton(
                    //         onPressed: () async {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 4),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 4),
                    //           );
                    //         },
                    //         child: Icon(
                    //           Icons.add_photo_alternate,
                    //           size: _mainHeight * 0.06,
                    //           color: blackColor,
                    //         ),
                    //       )
                    //           : InkWell(
                    //         onTap: () {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 4),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 4),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           width: _mainWidth * 0.27,
                    //           height: _mainHeight * 0.1,
                    //           child: ClipRRect(
                    //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //               child: Image.network(
                    //                 controller.imageUrl4,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: _mainHeight * 0.1,
                    //       width: _mainWidth * 0.27,
                    //       child: controller.imageUrl5.isEmpty
                    //           ? getElevatedButton(
                    //         onPressed: () async {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 5),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 5),
                    //           );
                    //         },
                    //         child: Icon(
                    //           Icons.add_photo_alternate,
                    //           size: _mainHeight * 0.06,
                    //           color: blackColor,
                    //         ),
                    //       )
                    //           : InkWell(
                    //         onTap: () {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 5),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 5),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           width: _mainWidth * 0.27,
                    //           height: _mainHeight * 0.1,
                    //           child: ClipRRect(
                    //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //               child: Image.network(
                    //                 controller.imageUrl5,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: _mainHeight * 0.1,
                    //       width: _mainWidth * 0.27,
                    //       child: controller.imageUrl6.isEmpty
                    //           ? getElevatedButton(
                    //         onPressed: () async {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 6),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 6),
                    //           );
                    //         },
                    //         child: Icon(
                    //           Icons.add_photo_alternate,
                    //           size: _mainHeight * 0.06,
                    //           color: blackColor,
                    //         ),
                    //       )
                    //           : InkWell(
                    //         onTap: () {
                    //           showImagePickerDialog(
                    //             context: Get.context!,
                    //             onCamera: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.camera, number: 6),
                    //             onGallery: () =>
                    //                 controller.onCaptureMediaClick(source: ImageSource.gallery, number: 6),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           width: _mainWidth * 0.27,
                    //           height: _mainHeight * 0.1,
                    //           child: ClipRRect(
                    //               borderRadius: const BorderRadius.all(Radius.circular(20)),
                    //               child: Image.network(
                    //                 controller.imageUrl6,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //     ),
                    //   ],

                    // ),

                    getElevatedButton(
                      onPressed: () async {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureMediaClick(
                              source: ImageSource.camera, number: 6),
                          onGallery: () => controller.onCaptureMediaClick(
                              source: ImageSource.gallery, number: 6),
                        );
                      },
                      child: Icon(
                        Icons.add_photo_alternate,
                        size: _mainHeight * 0.06,
                        color: blackColor,
                      ),
                    ),
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
                          Get.toNamed(RoutesConst.addEventSpecialsScreen,
                              arguments: controller.eventNameController.text);
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

  Widget getSelectUserView() {
    return Column(
      children: [
        controller.userSelected
            ? Column(
                children: [
                  const Text(
                    'Selected  User',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                        fontSize: 22),
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
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
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
          decoration: BoxDecoration(
              color: greyColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _mainHeight * 0.06,
                width: _mainWidth * 0.14,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: controller.selectedUser.imageUrl != null &&
                          controller.selectedUser.imageUrl != ''
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
                  Text(controller.selectedUser.name ?? '',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: _mainHeight * 0.005,
                  ),
                  Text(controller.selectedUser.email ?? '',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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
