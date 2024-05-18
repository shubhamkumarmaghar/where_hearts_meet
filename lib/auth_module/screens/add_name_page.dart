import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/controller/profile_setup_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../../utils/util_functions/app_pickers.dart';
import '../../utils/widgets/custom_text_field.dart';

class AddNamePage extends StatelessWidget {
  final ProfileSetupController controller;
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  AddNamePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: _mainHeight*0.12
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Personal Details',style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,

            ),
            ),
          ),
          SizedBox(
            height: _mainHeight * 0.05,
          ),
          Obx(
            () => CustomTextField(
                title: 'Name*',
                error: controller.errorNameText.value,
                hint: 'Please enter name',
                onChanged: controller.onNameChanged,
                controller: controller.nameTextController),
          ),
          SizedBox(
            height: _mainHeight * 0.03,
          ),
          Obx(
                () => CustomTextField(
                title: 'Mobile Number',
                inputType: TextInputType.phone,
                error: controller.errorMobileText.value,
                hint: 'Please enter mobile number',
                onChanged: controller.onMobileChanged,
                controller: controller.mobileTextController),
          ),
          SizedBox(
            height: _mainHeight * 0.03,
          ),
          const Text(
            'Select Date of Birth',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          SizedBox(
            height: _mainHeight * 0.02,
          ),
          Obx(
            () => InkWell(
              onTap: () async {
                final date = await dateOfBirthPicker(context: context);
                if (date != null) {
                  controller.birthDateTextController.text = '${date.year}-${date.month}-${date.day}';
                  controller.dateOfBirth.value = controller.birthDateTextController.text;
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
                      controller.dateOfBirth.value,
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
          ),
          SizedBox(
            height: _mainHeight * 0.03,
          ),
        ],
      ),
    );
  }
}
