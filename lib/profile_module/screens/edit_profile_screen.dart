import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/util_functions/app_pickers.dart';
import 'package:where_hearts_meet/utils/widgets/custom_text_field.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';

import '../../utils/widgets/app_bar_widget.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<EditProfileController>();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: 'Profile'),
      body: GetBuilder<EditProfileController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              height: _mainHeight,
              width: _mainWidth,
              color: whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: controller.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: _mainHeight * 0.02,
                          ),
                          Center(
                            child: SizedBox(
                                width: _mainWidth * 0.26,
                                height: _mainHeight * 0.12,
                                child: getElevatedButton(
                                  buttonColor: whiteColor,
                                  onPressed: () async {
                                    showImagePickerDialog(
                                      context: Get.context!,
                                      onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera),
                                      onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery),
                                    );
                                  },
                                  child: controller.userInfoModel.imageUrl != null &&
                                          controller.userInfoModel.imageUrl != ''
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                                          child: Image.network(
                                            controller.userInfoModel.imageUrl ?? '',
                                            fit: BoxFit.cover,
                                          ))
                                      : Icon(
                                          Icons.image_rounded,
                                          size: _mainHeight * 0.06,
                                          color: blackColor,
                                        ),
                                )),
                          ),
                          SizedBox(
                            height: _mainHeight * 0.03,
                          ),
                          Obx(
                            () => CustomTextField(
                                title: 'Name',
                                error: controller.errorNameText.value,
                                hint: 'Please enter name',
                                onChanged: controller.onNameChanged,
                                controller: controller.nameTextController),
                          ),
                          SizedBox(
                            height: _mainHeight * 0.03,
                          ),
                          CustomTextField(
                              title: 'Email',
                              hint: 'Please enter email',
                              enabled: false,
                              onChanged: (email) {},
                              controller: controller.emailController),
                          SizedBox(
                            height: _mainHeight * 0.03,
                          ),
                          const Text(
                            'Date of Birth',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          SizedBox(
                            height: _mainHeight * 0.02,
                          ),
                          InkWell(
                            onTap: () async {
                              final date = await dateOfBirthPicker(context: context);
                              if (date != null) {
                                controller.updateDateOfBirth(dateOfBirth: '${date.year}-${date.month}-${date.day}');
                              }
                            },
                            child: Container(
                              height: _mainHeight * 0.055,
                              width: _mainWidth,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor, width: 0.3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.only(right: _mainWidth * 0.05, left: _mainWidth * 0.03),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    controller.userInfoModel.dateOfBirth ?? '',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: primaryColor,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _mainHeight * 0.03,
                          ),
                          const Text("People's List",
                              style: TextStyle(color: blackColor, fontSize: 18.0, fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: _mainHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: _mainHeight * 0.02, left: 16, right: 16),
        height: _mainHeight * 0.08,
        child: GradientButton(
          title: 'Save',
          onPressed: () async {
            await controller.updateUserData();
          },
        ),
      ),
    );
  }
}
