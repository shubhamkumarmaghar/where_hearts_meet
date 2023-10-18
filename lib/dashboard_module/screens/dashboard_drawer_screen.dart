import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_login.dart';

import '../../utils/consts/color_const.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardDrawerScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final firebaseAuthController = Get.find<FirebaseAuthController>();

  DashboardDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: _mainWidth * 0.75,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              firebaseAuthController.getCurrentUser()?.displayName ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            accountEmail: Text(firebaseAuthController.getCurrentUser()?.email ?? ''),
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
          getDrawerContentWidget(icon: Icons.wallet_giftcard, heading: "Received Gifts", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          // getDrawerContentWidget(icon: Icons.pending, heading: "Pending Approvals", onTap: () {}),
          // SizedBox(
          //   height: _mainHeight * 0.01,
          // ),
          getDrawerContentWidget(icon: Icons.settings, heading: "Settings", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.help_outline, heading: "Help & Support", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(
              icon: Icons.logout,
              heading: "Logout",
              onTap: () async {
                showLoaderDialog(context: Get.context!);
                final controller = Get.find<FirebaseAuthController>();
                await controller.logOut();
                cancelLoaderDialog();
                Get.offAllNamed(RoutesConst.loginScreen);
              }),
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
