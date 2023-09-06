import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/widgets/dashboard_widgets.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

class DashboardScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [Container(margin: EdgeInsets.only(right: _mainWidth * 0.04), child: const Icon(Icons.notifications))],
      ),
      drawer: Drawer(
        width: _mainWidth * 0.75,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                'Deepak',
                style: TextStyle(fontSize: 20),
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
      ),
      body: Container(),
    );
  }


}
