import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/util_functions/app_pickers.dart';
import 'package:where_hearts_meet/utils/widgets/custom_text_field.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';

import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<EditProfileController>();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add People'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: _mainHeight,
          width: _mainWidth,
          color: whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        Text(controller.dateOfBirth.value,style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                        ),),
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
              const Text(
                'Choose Relation',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(
                height: _mainHeight * 0.02,
              ),
              Obx(
                () => Container(
                  height: _mainHeight * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 0.3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.only(right: _mainWidth * 0.05, left: _mainWidth * 0.03),
                  child: DropdownButton<String>(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: primaryColor,
                      size: 25,
                    ),
                    iconEnabledColor: primaryColor,
                    iconDisabledColor: primaryColor,
                    underline: const SizedBox.shrink(),
                    isExpanded: true,
                    items: controller
                        .getRelationDropdownList()
                        .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Center(
                              child: Text(
                                e.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )))
                        .toList(),
                    onChanged: (String? val) {
                      if (val != null) {
                        controller.relationValue.value = val;
                      }
                    },
                    value: controller.relationValue.value,
                  ),
                ),
              ),
              SizedBox(
                height: _mainHeight * 0.03,
              ),
              const Text(
                'Upload Profile Pic',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(
                height: _mainHeight * 0.02,
              ),
              Container(
                alignment: Alignment.center,
                height: _mainHeight * 0.15,
                child: getElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.upload_rounded,
                    size: _mainHeight * 0.12,
                    color: primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: GradientButton(
                    title: 'Save',
                    height: _mainHeight*0.06,
                    width: _mainWidth*0.8,
                    onPressed: () {},),
              ),
              SizedBox(
                height: _mainHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
