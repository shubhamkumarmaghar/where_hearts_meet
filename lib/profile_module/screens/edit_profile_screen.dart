import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/util_functions/app_pickers.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: 14,
          left: screenWidth * 0.06,
          right: screenWidth * 0.06,
        ),
        child: GradientButton(
            title: 'Update',
            width: screenWidth * 0.8,
            enabled: true,
            onPressed: (){},
            buttonColor: appColor1,
            titleTextStyle: textStyleDangrek(fontSize: 22)

        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
            //gradient: backgroundGradient
            ),
        padding: const EdgeInsets.symmetric(
            //horizontal: 20
            ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //https://cdn.wallpapersafari.com/90/1/9BTVDQ.jpg
              Stack(
                children: [

                  Column(
                    children: [
                      Container(
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        color: primaryColor,
                        child: cachedImage(imageUrl: 'https://cdn.wallpapersafari.com/90/1/9BTVDQ.jpg'),
                      ),
                      Container(
                        height: screenHeight * 0.7,
                        width: screenWidth,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Positioned(
                    top: screenHeight * 0.23,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: screenWidth,
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: cachedImage(imageUrl: 'https://cdn.wallpapersafari.com/90/1/9BTVDQ.jpg'),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.04,
                                ),

                                Spacer(),
                                Container(
                                    margin: EdgeInsets.only(right: screenWidth * 0.1),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          textField(textController: controller.firstNameController, label: 'First Name'),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          textField(textController: controller.lastNameController, label: 'Last Name'),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          textField(textController: controller.mobileController, label: 'Phone Number', enable: false),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          textField(textController: controller.emailController, label: 'Email'),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          textField(textController: controller.addressController, label: 'Address'),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget textField({required TextEditingController textController, required String label, bool? enable}) {
  return Container(
    height: 50,
    width: screenWidth * 0.87,
    //color: Colors.amber,
    child: TextField(
      enabled: enable,
      style: textStyleAbel(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),

      controller: textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: 10,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: primaryColor.withOpacity(0.4),
            )),
        label: Text(
          label,
          style: textStyleDangrek(color: Colors.grey.shade400, fontSize: 18,fontWeight: FontWeight.w300),
        ),

      ),
    ),
  );
}
/*
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
    */
