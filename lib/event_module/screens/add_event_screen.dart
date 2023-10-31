import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
          child: Container(
            height: _mainHeight,
            width: _mainWidth,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      title: 'Name',
                      hint: 'enter name',
                      onChanged: (text){},
                      controller: controller.nameController),
                  SizedBox(
                    height: _mainHeight * 0.03,
                  ),
                  CustomTextField(
                      title: 'Event Name',
                      hint: 'Enter event name',
                      onChanged: (text){},
                      controller: controller.eventNameController),
                  SizedBox(
                    height: _mainHeight * 0.03,
                  ),
                  CustomTextField(
                      title: 'Title ',
                      hint: 'Enter title text',
                      onChanged: (text){},
                      controller: controller.titleController),
                  SizedBox(
                    height: _mainHeight * 0.03,
                  ),
                  CustomTextField(
                      title: 'Subtitle',
                      hint: 'Enter subtitle text',
                      onChanged: (text){},
                      controller: controller.subtitleController),
                  SizedBox(
                    height: _mainHeight * 0.03,
                  ),
                  CustomTextField(
                      title: 'Info',
                      hint: 'Enter Info',
                      onChanged: (text){},
                      controller: controller.infoController),
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
                    child: controller.imageUrl.isEmpty
                        ? NeumorphicButton(
                      onPressed: () async {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera),
                          onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery),
                        );
                      },
                      style: NeumorphicStyle(
                        color: greyColor.withOpacity(0.1),
                        depth: -5,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                      ),
                      child: Icon(
                        Icons.upload_rounded,
                        size: _mainHeight * 0.12,
                        color: blackColor,
                      ),
                    )
                        : InkWell(
                      onTap: () {
                        showImagePickerDialog(
                          context: Get.context!,
                          onCamera: () => controller.onCaptureMediaClick(source: ImageSource.camera),
                          onGallery: () => controller.onCaptureMediaClick(source: ImageSource.gallery),
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            controller.imageUrl,
                            fit: BoxFit.fitWidth,
                            width: _mainWidth * 0.35,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.03,
                  ),
                  Center(
                    child: GradientButton(
                      title: 'Save',
                      height: _mainHeight*0.06,
                      width: _mainWidth*0.8,
                      onPressed: ()async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await controller.addEvent();
                      },),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
