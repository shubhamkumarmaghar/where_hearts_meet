import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:where_hearts_meet/guest_dashboard/view/timeline_screen.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/text_styles/custom_text_styles.dart';
import 'package:where_hearts_meet/utils/widgets/designer_text_field.dart';
import 'package:where_hearts_meet/utils/widgets/gradient_button.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../controller/guest_dashboard_controller.dart';
import '../guest_home/controller/guest_home_controller.dart';
import '../guest_home/view/guest_home.dart';
import '../guest_wishlist/view/guest_wishlist.dart';

class GuestDashboard extends StatefulWidget {
  const GuestDashboard({super.key});

  @override
  State<GuestDashboard> createState() => _GuestDashboardState();
}

class _GuestDashboardState extends State<GuestDashboard>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    /*   _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestDashboardController>(
        init: GuestDashboardController(),
        builder: (controller) {
          return  Scaffold(
              body:
              controller.isBusy ? AppWidgets.getLoader():
              Container(
            width: screenWidth,
            height: screenHeight,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff9467ff),
                    Color(0xffae8bff),
                    Color(0xffc7afff),
                    Color(0xffdfd2ff),
                    Color(0xfff2edff),
                  ]),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heightSpace(screenHeight * 0.3),
                  getPrimaryText(
                      text: 'Get Your Event',
                      fontSize: 30,
                      textColor: Colors.white),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DesignerTextField(
                      onChanged: (value) {},
                      controller: controller.textController,
                      hint: 'Enter Event Code',
                    ),
                  ),
                  GradientButton(
                      title: 'Get Event',
                      onPressed: () async {
                        controller.textController.text.isNotEmpty
                            ? await controller.getEventDetails(
                                eventId: controller.textController.text,
                              )
                            : AppWidgets.getToast(
                                message: 'Please enter valid Event Code');
                      }),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesConst.guestQrScannerScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              getPrimaryText(
                                  text: 'SCAN QR CODE', fontSize: 20),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.qr_code_rounded,
                            size: 50,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ));
        });
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    TabBarView(
      physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
      // controller: _tabController,
      controller: _motionTabBarController,
      children: <Widget>[
         Center(
          child:TimelineStoriesSreen(),
          //VideoPlayerWidget(url: 'https://media.geeksforgeeks.org/wp-content/uploads/20230924220731/video.mp4'),

        ),
        const Center(
          child:GuestHome(),
        ),
         Center(
          child:
          GuestWishList(),
        ),
      ],
    ),
    // Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [
    //           Color(0xff9467ff),
    //           Color(0xffae8bff),
    //           Color(0xffc7afff),
    //           Color(0xffdfd2ff),
    //           Color(0xfff2edff),
    //         ]),
    //   ),
    // ),
bottomNavigationBar:
MotionTabBar(initialSelectedTab: 'Home',
  labels: const ["Dashboard", "Home", "Profile",],
  controller: _motionTabBarController,
  icons: const [Icons.dashboard,
    Icons.home,
    Icons.people_alt],
      useSafeArea: true,
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: const TextStyle(
        fontSize: 12,
        color: primaryColor,
        fontWeight: FontWeight.w600,
      ),
      tabIconColor: primaryColor,
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor: primaryColor,
      tabIconSelectedColor: appColor4,
      tabBarColor: appColor3,
      onTabItemSelected: (int value) {
        setState(() {
          // _tabController!.index = value;
          _motionTabBarController!.index = value;
        });
      },
    ));
  }*/
}
