import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/event_special_const.dart';
import 'package:where_hearts_meet/utils/dialogs/select_data_dialog.dart';
import 'package:where_hearts_meet/utils/repository/gift_cards_data.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/text_styles/custom_text_styles.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_event_specials_controller.dart';

class AddGiftCardScreen extends StatelessWidget {
  const AddGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEventSpecialsController>(
      builder: (controller) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.onPreviousScreen(EventSpecialPageIndex.addWishes);
                    },
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  getPrimaryText(text: 'Add GiftCards', fontWeight: FontWeight.w700, fontSize: 20),
                  GestureDetector(
                    onTap: (){
                      controller.onNextScreen(EventSpecialPageIndex.addTimeline);
                    },
                    child: Container(
                      height: 25,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                      child: getPrimaryText(text: 'Skip', textColor: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              GestureDetector(
                onTap: () async {
                  controller.selectGiftCard();
                },
                child: Container(
                  height: 50,
                  width: screenWidth,
                  decoration:
                  BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      const Icon(
                        Icons.card_giftcard,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      getPrimaryText(
                          text: controller.giftCardNameController.text.trim().isEmpty
                              ? 'Add GiftCard'
                              : controller.giftCardNameController.text,
                          fontWeight: controller.giftCardNameController.text.trim().isEmpty
                              ? FontWeight.w500
                              : FontWeight.w600,
                          fontSize: controller.giftCardNameController.text.trim().isEmpty ? 14 : 16),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: controller.giftId != null && controller.giftId == 0,
                replacement: const SizedBox.shrink(),
                child: SizedBox(
                  height: screenHeight * 0.04,
                ),
              ),
              Visibility(
                visible: controller.giftId != null && controller.giftId == 0,
                replacement: const SizedBox.shrink(),
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: CustomTextField(
                      title: 'Virtual gift title',
                      hint: 'Enter virtual gift title',
                      onChanged: (text) {},
                      controller: controller.giftCardNameController),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                width: screenWidth * 0.8,
                child: CustomTextField(
                    title: 'Gift card voucher',
                    hint: 'Enter gift card voucher',
                    onChanged: (text) {},
                    controller: controller.giftCardPinController),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                width: screenWidth * 0.8,
                child: CustomTextField(
                    title: 'Gift card pin*',
                    hint: 'Enter gift card pin',
                    onChanged: (text) {},
                    controller: controller.giftCardMessageController),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                width: screenWidth * 0.8,
                child: CustomTextField(
                    title: 'Message if any',
                    hint: 'Enter message if any',
                    onChanged: (text) {},
                    controller: controller.giftCardMessageController),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth * 0.8,
                child: GradientButton(title: 'Save', onPressed: () {}),
              )
            ],
          ),
        );
      },
    );
  }
}
