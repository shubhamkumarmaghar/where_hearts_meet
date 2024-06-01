import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardDrawerScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  final DashboardController dashboardController;

  DashboardDrawerScreen({Key? key, required this.dashboardController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: _mainWidth * 0.65,
      child: Column(
        children: [
          getUserAccountHeader(context: context),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(
              icon: Icons.list,
              heading: "Created Events",
              onTap: () {
                Get.toNamed(RoutesConst.eventListScreen);
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
               // Get.toNamed(RoutesConst.eventListScreen);
              }),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.settings, heading: "Settings", onTap: () {}),
          SizedBox(
            height: _mainHeight * 0.01,
          ),
          getDrawerContentWidget(icon: Icons.help_outline, heading: "Help & Support", onTap: () async {}),
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
                      await GetStorage().erase();
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

  UserAccountsDrawerHeader getUserAccountHeader({required BuildContext context}) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(color: appColor3),
      accountName: Text(
        (GetStorage().read(firstName))?.toString().capitalizeFirst ?? '',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      otherAccountsPictures: [
        InkWell(
          onTap: () {
            Get.toNamed(RoutesConst.editProfileScreen);
          },
          child: const CircleAvatar(
              backgroundColor: blackColor,
              child: Icon(
                Icons.edit,
                color: whiteColor,
                size: 25,
              )),
        )
      ],
      accountEmail: Text(
        (GetStorage().read(userMobile))?.toString().capitalizeFirst ?? '',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      currentAccountPicture: InkWell(
        onTap: () {
          dashboardController.showLogoutAlertDialog(context: context, logOutFunction: () {});
        },
        child: CircleAvatar(
            backgroundColor: whiteColor,
            child: firebaseAuthController.getCurrentUser()?.photoURL == ''
                ? const Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/5231/5231019.png',
                      // GetStorage().read(profileUrl) ?? '',
                      fit: BoxFit.fitWidth,
                      width: _mainWidth * 0.2,
                    ))),
      ),
    );
  }
}
