import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../../utils/widgets/base_container.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_people_controller.dart';

class AddPeopleScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  final controller = Get.find<AddPeopleController>();

  AddPeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add People'),
      ),
      body: BaseContainer(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: GetBuilder<AddPeopleController>(
            builder: (controller) {
              return Container(
                width: _mainWidth,
                height: _mainHeight,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: controller.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.userSelected
                              ? Column(
                                  children: [
                                    const Text(
                                      'Selected User',
                                      style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor, fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: _mainHeight * 0.02,
                                    ),
                                  ],
                                )
                              : Spacer(),
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
                                      width: _mainWidth * 0.7,
                                      decoration: const BoxDecoration(
                                          color: blackColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: const Text(
                                        'Select  User',
                                        style: TextStyle(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                          const Spacer(),
                          GradientButton(
                            title: 'Continue',
                            enabled: controller.userSelected ? true : false,
                            height: _mainHeight * 0.06,
                            width: _mainWidth,
                            onPressed: () async {
                              await controller.addPeople();
                            },
                          )
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget selectedUserView({required AddPeopleController controller}) {
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
          title: 'Select Another User',
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
