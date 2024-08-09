import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/widgets/app_bar_widget.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          body: controller.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: BoxDecoration(gradient: backgroundGradient),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Column(
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
                                'Profile',
                                style: textStyleDangrek(color: Colors.white, fontSize: 20),
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: cachedImage(
                                height: screenHeight * 0.24,
                                width: screenWidth,
                                imageUrl: controller.userModel.profilePic ?? '',
                                boxFit: BoxFit.cover),
                          ),
                          SizedBox(
                            height: screenHeight * 0.08,
                          ),
                          Center(
                            child: Text(
                              controller.userModel.firstName ?? '',
                              style: textStyleDangrek(color: Colors.white, fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Expanded(
                            child: Container(
                              width: screenWidth,
                              padding:
                                  EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text(
                                        text: 'Name',
                                        value:
                                            '${controller.userModel.firstName ?? ''} ${controller.userModel.lastName ?? ''}',
                                        onTap: () {}),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    text(text: 'Phone', value: controller.userModel.phoneNumber ?? '', onTap: () {}),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    text(text: 'Email', value: controller.userModel.email ?? '', onTap: () {}),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    text(
                                        text: 'Date of birth',
                                        value: controller.userModel.dateOfBirth ?? '',
                                        onTap: () {}),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    text(text: 'Gender', value: controller.userModel.gender ?? '', onTap: () {}),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    text(text: 'Address', value: controller.userModel.address ?? '', onTap: () {}),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                        ],
                      ),
                      Positioned(
                        top: screenHeight * 0.29,
                        left: screenWidth * 0.28,
                        child: SizedBox(
                          height: screenHeight * 0.15,
                          width: screenHeight * 0.15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: cachedImage(imageUrl: controller.userModel.profilePic ?? ''),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.39,
                        right: screenWidth * 0.28,
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
        );
      },
    );
  }
}

Widget text({required String text, required String value, required Function onTap}) {
  if (value.isEmpty) {
    return const SizedBox.shrink();
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: textStyleAbel(fontSize: 14),
          ),
          SizedBox(
            width: screenWidth * 0.7,
            child: Text(
              value,
              style: textStyleAbel(fontSize: 20),
            ),
          )
        ],
      ),
      const Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      )
    ],
  );
}
