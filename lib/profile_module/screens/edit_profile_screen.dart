import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/util_functions/app_pickers.dart';
import 'package:where_hearts_meet/utils/widgets/custom_text_field.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/widgets/app_bar_widget.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
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
              height: screenHeight,
              width: screenWidth,
              color: whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: controller.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Center(
                            child: SizedBox(
                                width: screenWidth * 0.26,
                                height: screenHeight * 0.12,
                                child: getElevatedButton(
                                  buttonColor: whiteColor,
                                  onPressed: () async {
                                    showImagePickerDialog(
                                      context: Get.context!,
                                      onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera),
                                      onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery),
                                    );
                                  },
                                  child:
                                      controller.userModel.profilePic != null && controller.userModel.profilePic != ''
                                          ? ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                                              child: Image.network(
                                                controller.userModel.profilePic ?? '',
                                                fit: BoxFit.cover,
                                              ))
                                          : Icon(
                                              Icons.image_rounded,
                                              size: screenHeight * 0.06,
                                              color: blackColor,
                                            ),
                                )),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
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
                            height: screenHeight * 0.03,
                          ),
                          CustomTextField(
                              title: 'Email',
                              hint: 'Please enter email',
                              enabled: false,
                              onChanged: (email) {},
                              controller: controller.emailController),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          const Text(
                            'Date of Birth',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          InkWell(
                            onTap: () async {
                              final date = await dateOfBirthPicker(context: context);
                              if (date != null) {
                                controller.updateDateOfBirth(dateOfBirth: '${date.year}-${date.month}-${date.day}');
                              }
                            },
                            child: Container(
                              height: screenHeight * 0.055,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor, width: 0.3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.03),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    controller.userModel.dateOfBirth ?? '',
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
                          ), SizedBox(
                            height: screenHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: screenHeight * 0.02, left: 16, right: 16),
        height: screenHeight * 0.08,
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
