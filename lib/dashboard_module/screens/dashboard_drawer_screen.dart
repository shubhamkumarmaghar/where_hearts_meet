import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardDrawerScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  final DashboardController dashboardController;

  DashboardDrawerScreen({Key? key,required this.dashboardController}) : super(key: key);

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
            otherAccountsPictures: const [
              CircleAvatar(
                  backgroundColor: blackColor,
                  child: Icon(Icons.edit,color: whiteColor,size: 25,))
            ],
            accountEmail: Text(firebaseAuthController.getCurrentUser()?.email ?? ''),
            currentAccountPicture: InkWell(
              onTap: (){
                dashboardController.showLogoutAlertDialog(context: context, logOutFunction: (){});
              },
              child: CircleAvatar(
                  backgroundColor: whiteColor,
                  child: firebaseAuthController.getCurrentUser()?.photoURL == null
                      ? const Icon(
                          Icons.person,
                          color: primaryColor,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            firebaseAuthController.getCurrentUser()?.photoURL ?? '',
                            fit: BoxFit.fitWidth,
                            width: _mainWidth * 0.2,
                          ))),
            ),
          ),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.list, heading: "Created Events", onTap: () {
            Get.toNamed(RoutesConst.createdEventListScreen);
          }),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(
              icon: Icons.person,
              heading: "People's List",
              onTap: () {
                Get.toNamed(RoutesConst.peopleListScreen);
              }),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(
              icon: Icons.wallet_giftcard,
              heading: "Received Events",
              onTap: () {
                Get.toNamed(RoutesConst.eventListScreen);
              }),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.settings, heading: "Settings", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(
              icon: Icons.help_outline,
              heading: "Help & Support",
              onTap: () async {
              }),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(
              icon: Icons.logout,
              heading: "Logout",
              onTap: () async {
                showLogoutAlertDialog(
                    context: Get.context!,
                    logOutFunction: () async {
                      showLoaderDialog(context: Get.context!);
                      final controller = Get.find<FirebaseAuthController>();
                      await controller.logOut();
                      cancelLoaderDialog();
                      Get.offAllNamed(RoutesConst.loginScreen);
                    });
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
