import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/view_event_details/event_home/controller/event_home_controller.dart';

import '../../../utils/consts/color_const.dart';
import '../../../utils/util_functions/decoration_functions.dart';

void showAddGiftsDialog({required BuildContext context, required EventHomeController controller}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        title: Row(
          children: [
            Icon(
              Icons.card_giftcard,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Gifts', style: textStyleBasic(fontSize: 18, color: primaryColor)),
          ],
        ),
        content: Text('No gifts found for this event. \nDo you want to add gifts to this event?',
            style: textStyleBasic(fontSize: 14, color: Colors.blueGrey)),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: darkGreyColor), // Customize text color
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ), // Add icon next to the button text
            label: Text(
              'Add Gifts',
              style: textStyleBasic(fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor, // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded button
              ),
            ),
          ),
        ],
      );
    },
  );
}
