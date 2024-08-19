import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/settings/view/settings_screen.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardDrawerScreen extends StatelessWidget {
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  final Function onDrawerClose;

  final DashboardController dashboardController;

  DashboardDrawerScreen({Key? key, required this.dashboardController, required this.onDrawerClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, screenHeight * 0.06, 5, screenHeight * 0.03),
      child: Drawer(
        width: screenWidth * 0.65,
        child: Container(
          padding: EdgeInsets.only(left: screenWidth * 0.05),
          decoration: BoxDecoration(gradient: backgroundGradient),
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
                    onTap: () async {
                      Get.to(() => CustomPhotoView(
                            imageUrl: dashboardController.userImage,
                          ));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: cachedImage(
                            imageUrl: dashboardController.userImage,
                            height: screenHeight * 0.065,
                            width: screenHeight * 0.065)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesConst.profileScreen, arguments: Screens.fromDashboard);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: screenWidth * 0.05),
                      child: ClayContainer(
                        borderRadius: 10,
                        color: primaryColor,
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.2,
                        child: Center(
                            child: Text(
                          'Edit',
                          style: textStyleDangrek(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                  dashboardController.userName != null && dashboardController.userName!.isNotEmpty
                      ? dashboardController.userName!
                      : "User",
                  style: textStyleDangrek(fontSize: 20)),
              Text(
                  dashboardController.userPhone != null && dashboardController.userPhone!.isNotEmpty
                      ? dashboardController.userPhone!
                      : "+91",
                  style: textStyleDangrek(fontSize: 20)),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              getDrawerContentWidget(
                  icon: Icons.list,
                  heading: "Created Events",
                  onTap: () {
                    Get.toNamed(RoutesConst.eventListScreen, arguments: EventsCreated.byUser);
                    onDrawerClose();
                  }),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              getDrawerContentWidget(
                  icon: Icons.wallet_giftcard,
                  heading: "Received Events",
                  onTap: () {
                    Get.toNamed(RoutesConst.eventListScreen, arguments: EventsCreated.forUser);
                    onDrawerClose();
                  }),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              getDrawerContentWidget(
                  icon: Icons.settings,
                  heading: "Settings",
                  onTap: () {
                    //Get.to(()=>SettingsScreen());
                  }),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              getDrawerContentWidget(icon: Icons.help_outline, heading: "Help & Support", onTap: () async {}),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              getDrawerContentWidget(
                  icon: Icons.logout,
                  heading: "Logout",
                  onTap: () async {
                    showLogoutAlertDialog(
                        context: Get.context!,
                        logOutFunction: () {
                          logoutFunction();
                        });
                  }),
              const Spacer(),
              Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.01, right: screenWidth * 0.025),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'v1.0',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
