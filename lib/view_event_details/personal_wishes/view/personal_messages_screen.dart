import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../create_event/model/personal_messages_model.dart';
import '../../../utils/consts/app_screen_size.dart';
import '../../../utils/consts/color_const.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/string_consts.dart';
import '../../../utils/shimmers/personal_messages_shimmer.dart';
import '../../../utils/util_functions/decoration_functions.dart';
import '../../../utils/widgets/app_bar_widget.dart';
import '../controller/personal_messages_controller.dart';

class PersonalMessagesScreen extends StatelessWidget {
  const PersonalMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalMessagesController>(
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            return controller.loadingState.value == LoadingState.loading
                ? const PersonalMessagesShimmer()
                : controller.loadingState.value == LoadingState.noData
                    ? const EmptyPersonalMessagesWidget()
                    : Opacity(
                        opacity: 0.9,
                        child: Container(
                          height: screenHeight,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: appColor1,
                            image: controller.personalMessagesModel!.image != null &&
                                    controller.personalMessagesModel!.image!.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(controller.personalMessagesModel!.image!), fit: BoxFit.cover)
                                : null,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.07,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                child: Row(
                                  children: [
                                    backIcon(),
                                    const Spacer(),
                                    Text(
                                      StringConsts.specialMessages,
                                      style: textStyleDangrek(fontSize: 24),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: controller.personalMessagesModel!.messages != null &&
                                        controller.personalMessagesModel!.messages!.isNotEmpty
                                    ? messageListView(controller.personalMessagesModel!)
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      );
          }),
        );
      },
    );
  }

  Widget messageListView(PersonalMessagesModel model) {
    return ListView.separated(
      itemCount: model.messages?.length ?? 0,
      padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.04),
      itemBuilder: (context, index) {
        var data = model.messages![index];
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(right: screenWidth * 0.15, left: screenWidth * 0.05),
            padding: EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.03, top: 8, bottom: 8),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Text(
              data,
              textAlign: TextAlign.left,
              style: textStyleAleo(
                color: convertIntToColor(model.textColor),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
