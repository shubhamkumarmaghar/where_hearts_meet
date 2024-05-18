import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event_module/screens/add_giftcard_screen.dart';
import 'package:where_hearts_meet/create_event_module/screens/add_wishes_screen.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/event_special_const.dart';
import 'package:where_hearts_meet/utils/routes/app_routes.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';
import '../../utils/consts/color_const.dart';
import '../controller/add_event_specials_controller.dart';

class AddEventSpecialsScreen extends StatelessWidget {
  const AddEventSpecialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEventSpecialsController>(
      builder: (controller) {
        log('mmmm ${controller.pageIndex}');
        return Scaffold(
            body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.only(left: 15, right: 15, top: screenHeight * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                  child: getStepper(controller: controller),
                ),
                SizedBox(height: screenHeight * 0.8, child: getPage(controller.pageIndex,controller)),
              ],
            ),
          ),
        ));
      },
    );
  }

  /*
  * Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getExtraGrid(icons: Icons.card_giftcard, title: 'Add virtual gifts/Gift Cards', onTap: () {}),
                getExtraGrid(icons: Icons.timeline, title: 'Add timeline history', onTap: () {}),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getExtraGrid(icons: Icons.cake_outlined, title: 'Add Wishes', onTap: () {
                  Get.toNamed(RoutesConst.addWishesScreen);
                }),
                getExtraGrid(icons: Icons.cake, title: 'Add Your personal wishes', onTap: () {}),
              ],
            )
          ],
        ),
      ),*/

  Widget getExtraGrid({required IconData icons, required String title, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Material(
        shadowColor: primaryColor,
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: screenWidth * 0.35,
          height: screenHeight * 0.15,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                size: 40,
                color: appColor3,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: appColor3, fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getPage(int index,AddEventSpecialsController controller) {
    switch (index) {
      case EventSpecialPageIndex.addWishes:
        return const AddWishesScreen();
      case EventSpecialPageIndex.addGiftCards:
        return const AddGiftCardScreen();
      case EventSpecialPageIndex.addTimeline:
        return const AddWishesScreen();
      case EventSpecialPageIndex.addSecretWishes:
        return const AddWishesScreen();
      default:
        return const Text('hello');
    }
  }

  Widget getStepper({required AddEventSpecialsController controller}) {
    return EasyStepper(
      activeStep: 2,
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 14,
      showStepBorder: true,
      steps: const [
        EasyStep(
          customStep: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          title: 'Event',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          title: 'Wishes',
        ),
        EasyStep(
          customStep: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          title: 'GiftCards',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          title: 'Timeline',
        ),
        EasyStep(
          customStep: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          title: 'Secret Wishes',
          topTitle: true,
        ),
      ],
      onStepReached: (index) {},
    );
  }
}
