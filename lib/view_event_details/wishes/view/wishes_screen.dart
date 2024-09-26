import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/string_consts.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../../utils/widgets/app_bar_widget.dart';
import '../../../utils/widgets/util_widgets/instagram_post_screen.dart';
import '../controller/wishes_controller.dart';

class WishesScreen extends StatelessWidget {
  const WishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishesController>(
        builder: (controller) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: Column(
                children: [
                  heightSpace(screenHeight * 0.06),
                  Row(
                    children: [
                      backIcon(),
                      const Spacer(),
                      Text(
                        StringConsts.wishes,
                        style: textStyleDangrek(fontSize: 24),
                      ),
                      const Spacer(),
                    ],
                  ),

                  heightSpace(screenHeight * 0.02),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.wishesList.length,
                        padding: const EdgeInsets.only(
                            bottom: 15
                        ),
                        separatorBuilder:(context, index) => const SizedBox(height: 15,) ,
                        itemBuilder: (context, index) {
                          var data = controller.wishesList[index];
                          return PostWidget(
                            username: data.senderName ?? '',
                            profileImageUrl: data.senderProfileImage.toString(),
                            likes: 5,
                            postImageUrl: data.imageUrls,
                            videoUrl: data.videoUrls!.isNotEmpty ? data.videoUrls : null,
                            caption: data.senderMessage.toString(),
                            fullDesc: true,
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
