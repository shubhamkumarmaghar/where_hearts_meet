
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_personal_memories_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/memory_card.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/outlined_busy_button.dart';

class CreatePersonalMemoriesScreen extends StatelessWidget {
  const CreatePersonalMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GetBuilder<CreatePersonalMemoriesController>(
          builder: (controller) {
            return Scaffold(
              bottomNavigationBar: Container(
                color: appColor3,
                padding: EdgeInsets.only(
                  bottom: 14,
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return GradientButton(
                        title: StringConsts.submit,
                        width: screenWidth * 0.4,
                        onPressed: controller.submitMemories,
                        buttonColor: appColor1,
                        enabled: controller.submitButtonEnabled.value,
                        titleTextStyle: textStyleDangrek(fontSize: 22),
                      );
                    }),
                    Obx(() {
                      return OutlinedBusyButton(
                        title: controller.nextButtonTitle.value,
                        width: screenWidth * 0.4,
                        titleTextStyle: textStyleDangrek(fontSize: 22, color: primaryColor),
                        onPressed: controller.onNext,
                        enabled: true,
                      );
                    }),
                  ],
                ),
              ),
              body: BaseContainer(
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.06,
                      ),
                      eventHeaderView(
                          text: controller.eventResponseModel.eventName ?? '',
                          image: controller.eventResponseModel.coverImage),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Text(
                            StringConsts.memories,
                            style: textStyleDangrek(fontSize: 24),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: controller.memoriesList.isNotEmpty,
                            child: GestureDetector(
                              onTap: controller.viewMemories,
                              child: CircleAvatar(
                                child: Text(controller.memoriesList.length.toString()),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      MemoryCard(
                        mediaUrl: controller.memoryImage != null && controller.memoryImage!.fileUrl != null
                            ? controller.memoryImage!.fileUrl!
                            : controller.memoryVideo != null && controller.memoryVideo!.fileUrl != null
                                ? controller.memoryVideo!.fileUrl!
                                : '',
                        mediaType: controller.memoryImage != null && controller.memoryImage!.fileUrl != null
                            ? MediaType.image
                            : controller.memoryVideo != null && controller.memoryVideo!.fileUrl != null
                                ? MediaType.video
                                : null,
                        onMediaTap: () {
                          controller.showCupertinoActionSheet();
                        },
                        textController: controller.memoryMessage,
                        isEditable: true,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
