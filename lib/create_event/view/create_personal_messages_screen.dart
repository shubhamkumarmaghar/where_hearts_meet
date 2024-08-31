import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/widgets/designer_text_field.dart';
import 'package:flutter/material.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../controller/create_personal_messages_controller.dart';

class CreatePersonalMessagesScreen extends StatelessWidget {
  const CreatePersonalMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: GetBuilder<CreatePersonalMessagesController>(
        builder: (controller) {

          return Scaffold(
            body: Opacity(
              opacity: 0.9,
              child: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: appColor1,
                  image: controller.backgroundImage != null &&
                          controller.backgroundImage!.fileUrl != null &&
                          controller.backgroundImage!.fileUrl!.isNotEmpty
                      ? DecorationImage(image: NetworkImage(controller.backgroundImage!.fileUrl!), fit: BoxFit.cover)
                      : null,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    // eventHeaderView(
                    //     text: controller.eventResponseModel.eventName ?? 'Happy Aruu',
                    //     image: controller.eventResponseModel.coverImage),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConsts.specialMessages,
                            style: textStyleDangrek(fontSize: 24),
                          ),
                          Obx(() {
                            return GestureDetector(
                              onTap: controller.isEditingMessage.value ? null : controller.submitPersonalMessages,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    color: controller.submitButtonEnabled.value ? Colors.white : Colors.grey.shade700,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white, width: 0.5)),
                                child: Text(
                                  StringConsts.submit,
                                  style: textStyleDangrek(
                                    fontSize: 16,
                                    color: controller.submitButtonEnabled.value
                                        ? primaryColor
                                        : Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: controller.messagesList.isNotEmpty
                          ? messageListView(controller)
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                  child: Text(
                                '${StringConsts.writeSomeSpecialMessages} ${controller.eventResponseModel.receiverName ?? ''}',
                                textAlign: TextAlign.center,
                                style: textStyleDancingScript(fontWeight: FontWeight.w700, fontSize: 40),
                              )),
                            ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.03, bottom: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: controller.isEditingMessage.value ? null : controller.showMessageOptions,
                            child: const Icon(
                              Icons.more_vert_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: screenWidth * 0.7,
                            child: DesignerTextField(
                              maxLines: 6,
                              cornerRadius: 10,
                              minLines: 1,
                              hint: StringConsts.message,
                              focusNode: controller.focusNode,
                              controller: controller.messageTextController,
                              inputType: TextInputType.multiline,
                              onChanged: (text) {},
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: controller.saveMessage,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.3)),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget messageListView(CreatePersonalMessagesController controller) {
    return ListView.separated(
      controller: controller.scrollController,
      itemCount: controller.messagesList.length,
      padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.04),
      itemBuilder: (context, index) {
        var data = controller.messagesList[index];
        return Obx(() {
          return GestureDetector(
            onLongPress: controller.isEditingMessage.value ? null : () => controller.onLongPress(index),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(left: screenWidth * 0.15, right: screenWidth * 0.05),
                padding: EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.03, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
                child: Text(
                  data.title,
                  textAlign: TextAlign.left,
                  style: textStyleAleo(
                    color: controller.textColor.value,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        });
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
