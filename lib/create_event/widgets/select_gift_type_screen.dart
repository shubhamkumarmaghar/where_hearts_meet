import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/gradient_button.dart';
import '../controller/create_gifts_controller.dart';

class SelectGiftCardScreen extends StatelessWidget {
  final controller = Get.find<CreateGiftsController>();

  SelectGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GetBuilder<CreateGiftsController>(
          builder: (controller) {
            return Scaffold(
              bottomNavigationBar: Container(
                color: appColor3,
                padding: EdgeInsets.only(
                  bottom: 14,
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: GradientButton(
                    title: 'Submit',
                    width: screenWidth * 0.8,
                    enabled: controller.selectedGift != null,
                    onPressed: controller.onGiftTypeSelected,
                    buttonColor: appColor1,
                    titleTextStyle: textStyleDangrek(fontSize: 22)),
              ),
              body: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(gradient: backgroundGradient),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap:controller.onPop,
                          child: Icon(
                            Platform.isIOS ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Text(
                          'Select E-Gifts',
                          style: textStyleDangrek(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Visibility(
                        visible: !controller.isBusy,
                        replacement: const CircularProgressIndicator.adaptive(),
                        child: Expanded(child: _getGiftCardView())),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _getGiftCardView() {
    if (controller.giftsDataList == null || controller.giftsDataList!.isEmpty) {
      return const SizedBox.shrink();
    }
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var data = controller.giftsDataList![index];
          return GestureDetector(
            onTap: () {
              controller.onSelectGiftCard(data.id);
            },
            child: Row(
              children: [
                Obx(() {
                  return Transform.scale(
                    scale: 1.2,
                    child: Radio<int>(
                        value: data.id ?? 0,
                        groupValue: controller.giftCardGroupValue.value,
                        activeColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.white;
                            }
                            return primaryColor;
                          },
                        ),
                        onChanged: controller.onSelectGiftCard),
                  );
                }),
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: screenWidth * 0.75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        data.image ?? '',
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: controller.giftsDataList?.length ?? 0);
  }
}
