import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/event_special_const.dart';
import 'package:where_hearts_meet/utils/dialogs/select_data_dialog.dart';
import 'package:where_hearts_meet/utils/repository/gift_cards_data.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/text_styles/custom_text_styles.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/add_event_specials_controller.dart';

class AddGiftCardScreen extends StatelessWidget {
  const AddGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEventSpecialsController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
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
                    getPrimaryText(text: 'Add GiftCards', fontWeight: FontWeight.w700, fontSize: 22),
                    Container(
                      height: 25,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
                      child: getPrimaryText(text: 'Skip', textColor: Colors.white, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                GestureDetector(
                  onTap: () {
                    selectDataDialog(
                        context: context,
                        title: 'Select GiftCard',
                        dataList: getGiftCardsDataList(),
                        height: screenHeight * 0.32);
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
                        getPrimaryText(text: 'Add GiftCard'),
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
                const Spacer(),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: GradientButton(title: 'Save', onPressed: () {}),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
