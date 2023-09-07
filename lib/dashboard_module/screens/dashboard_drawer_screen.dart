import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/consts/color_const.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardDrawerScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
   DashboardDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: _mainWidth * 0.75,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Deepak',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
            ),
            accountEmail: const Text('deepak4@gmail.com'),
            currentAccountPictureSize: Size(_mainHeight * 0.06, _mainWidth * 0.2),
            currentAccountPicture: const CircleAvatar(
                backgroundColor: whiteColor,
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                )),
          ),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.list, heading: "Sender's List", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.person, heading: "Profile", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.published_with_changes, heading: "Change Theme", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.wallet_giftcard, heading: "Received Gifts", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.pending, heading: "Pending Approvals", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.settings, heading: "Settings", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.help_outline, heading: "Help & Support", onTap: () {}),
          const Spacer(),
          Container(
              margin: EdgeInsets.only(bottom: _mainHeight * 0.01, right: _mainWidth * 0.025),
              alignment: Alignment.centerRight,
              child: const Text(
                'v1.0',
              )),
        ],
      ),
    );
  }
}
