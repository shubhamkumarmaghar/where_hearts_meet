import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/app_state_widget.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import 'package:where_hearts_meet/utils/widgets/designer_text_field.dart';
import 'package:where_hearts_meet/utils/widgets/no_data_screen.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/shimmers/profile_shimmer.dart';
import '../../utils/widgets/app_bar_widget.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/profile_controller.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.find<ProfileController>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        controller.userModel.profilePic = 'https://www.economist.com/sites/default/files/20181006_BLP501.jpg';
        return Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            color: appColor1,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: AppStateWidget(
              loadingState: controller.loadingState,
              noDataWidget: const NoDataScreen(
                showBackIcon: true,
              ),
              loadingWidget: const ProfileScreenShimmer(),
              dataWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.07,
                  ),
                  Row(
                    children: [
                      backIcon(color: Colors.white),
                      const Spacer(),
                      Text(
                        StringConsts.profile,
                        style: textStyleDangrek(color: Colors.white, fontSize: 20),
                      ),
                      const Spacer(),
                      Obx(() {
                        return GradientButton(
                          title: StringConsts.save,
                          buttonCorner: 10,
                          height: screenHeight * 0.04,
                          enabled: controller.isDataChanged.value,
                          titleTextStyle: textStyleDangrek(color: primaryColor, fontSize: 16),
                          buttonColor: Colors.white,
                          width: screenWidth * 0.2,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            controller.updateUserDetails();
                          },
                        );
                      })
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          height: screenHeight * 0.15,
                          width: screenHeight * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: cachedImage(imageUrl: controller.userModel.profilePic ?? ''),
                          ),
                        ),
                        Positioned(
                          bottom: screenHeight * 0.00,
                          right: screenWidth * 0.00,
                          child: const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Align(alignment: Alignment.center, child: showProfileCompletionPercentage(completed: 41)),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailsTextField(
                              text: 'First name',
                              textController: controller.firstNameTextController,
                              onTap: () {
                                Get.toNamed(RoutesConst.profileSetUpScreen);
                              }),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _detailsTextField(
                              text: 'Last name',
                              textController: controller.lastNmeTextController,
                              onTap: () {
                                Get.toNamed(RoutesConst.profileSetUpScreen);
                              }),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _detailsTextField(
                            text: 'Phone',
                            textController: controller.phoneTextController,
                            enable: false,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _detailsTextField(
                            text: 'Email',
                            textController: controller.emailTextController,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _userField(
                            value: controller.userModel.dateOfBirth ?? '',
                            text: 'Date of birth',
                            onTap: controller.onSelectDOB,
                          ),

                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _userField(
                            value: controller.userModel.gender ?? '',
                            text: 'Gender',
                            onTap: controller.selectGender,
                          ),

                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          _detailsTextField(
                            text: 'Address',
                            textController: controller.addressTextController,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailsTextField(
      {required String text,
      required TextEditingController textController,
      required Function onTap,
      bool enable = true}) {
    return DesignerTextField(
      onTap: onTap,
      onChanged: (text) {
        controller.isDataChanged.value = true;
      },
      title: text,
      enabled: enable,
      controller: textController,
    );
  }

  Widget _userField({required String text, required Function onTap, required String value}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: textStyleDangrek(fontSize: 18),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Container(
            height: 50,
            width: screenWidth,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: screenWidth * 0.03),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Text(
              value,
              style: const TextStyle(color: blackColor, fontSize: 14.0, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
