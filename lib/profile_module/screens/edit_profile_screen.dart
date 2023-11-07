import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/buttons/buttons.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/util_functions/app_pickers.dart';
import 'package:where_hearts_meet/utils/widgets/custom_text_field.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';

import '../controller/edit_profile_controller.dart';
import '../model/people_model.dart';

class EditProfileScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final controller = Get.find<EditProfileController>();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: GetBuilder<EditProfileController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              height: _mainHeight,
              width: _mainWidth,
              color: whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child:controller.isBusy?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
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
                            child: controller.userInfoModel.imageUrl != null && controller.userInfoModel.imageUrl != ''
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
                    const Text("People's List",style:TextStyle(color: blackColor, fontSize: 18.0, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: _mainHeight * 0.02,
                    ),
                    getPeopleListView(list: controller.userPeopleList),
                    SizedBox(
                      height: _mainHeight * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: _mainHeight*0.02,left: 16,right: 16),
        height: _mainHeight*0.08,
        child: GradientButton(
          title: 'Save',
          onPressed: () async{
            await controller.updateUserData();
          },
        ),
      ),
    );
  }

  Widget getPeopleListView({required List<PeopleModel> list}) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var data = list[index];
          return Container(
            height: _mainHeight*0.09,
            decoration: BoxDecoration(color: greyColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _mainHeight * 0.06,
                  width: _mainWidth * 0.14,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: data.imageUrl != null && data.imageUrl != ''
                        ? Image.network(
                            data.imageUrl ?? '',
                            fit: BoxFit.fill,
                          )
                        : const Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  width: _mainWidth * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: _mainHeight * 0.001,
                    ),
                    Text(data.email ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: ()async{
                    await controller.deletePeople(uid: data.uid ?? '');
                  },
                  child: const CircleAvatar(
                      backgroundColor: redColorDefault,
                      child: Icon(Icons.delete,color: whiteColor,)),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: list.length);
  }
// Widget getRelationView({required EditProfileController controller}) {
//   return Column(
//     children: [
//       const Text(
//         'Choose Relation',
//         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//       ),
//       SizedBox(
//         height: _mainHeight * 0.02,
//       ),
//       Obx(
//             () => Container(
//           height: _mainHeight * 0.055,
//           decoration: BoxDecoration(
//             border: Border.all(color: primaryColor, width: 0.3),
//             borderRadius: BorderRadius.circular(50),
//           ),
//           padding: EdgeInsets.only(right: _mainWidth * 0.05, left: _mainWidth * 0.03),
//           child: DropdownButton<String>(
//             borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//             icon: const Icon(
//               Icons.arrow_drop_down_sharp,
//               color: primaryColor,
//               size: 25,
//             ),
//             iconEnabledColor: primaryColor,
//             iconDisabledColor: primaryColor,
//             underline: const SizedBox.shrink(),
//             isExpanded: true,
//             items: controller
//                 .getRelationDropdownList()
//                 .map((e) => DropdownMenuItem(
//                 value: e.value,
//                 child: Center(
//                   child: Text(
//                     e.title,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: blackColor,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 )))
//                 .toList(),
//             onChanged: (String? val) {
//               if (val != null) {
//                 controller.relationValue.value = val;
//               }
//             },
//             value: controller.relationValue.value,
//           ),
//         ),
//       ),
//       SizedBox(
//         height: _mainHeight * 0.03,
//       ),
//     ],
//   );
// }
}
