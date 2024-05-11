import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:where_hearts_meet/event_module/controller/add_event_specials_controller.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';

import '../../utils/consts/color_const.dart';

class AddEventSpecialsScreen extends StatelessWidget {
  final extraController = Get.find<AddEventSpecialsController>();


  AddEventSpecialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: 'Add Specials To ${extraController.eventName}'),
      backgroundColor: appColor5,
      body: Container(
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
                getExtraGrid(icons: Icons.cake_outlined, title: 'Add Wishes', onTap: () {}),
                getExtraGrid(icons: Icons.cake, title: 'Add Your personal wishes', onTap: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getExtraGrid({required IconData icons, required String title, required Function onTap}) {
    return Material(
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
              style: TextStyle(color: appColor3, fontSize: 14, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
