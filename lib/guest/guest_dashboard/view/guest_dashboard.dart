import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:where_hearts_meet/guest/guest_dashboard/view/timeline_screen.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import '../guest_home/controller/guest_home_controller.dart';
import '../guest_home/view/guest_home.dart';
import '../guest_wishlist/view/guest_wishlist.dart';
class GuestDashboard extends StatefulWidget {
  const GuestDashboard({super.key});

  @override
  State<GuestDashboard> createState() => _GuestDashboardState();
}

class _GuestDashboardState extends State<GuestDashboard> with TickerProviderStateMixin {

  MotionTabBarController? _motionTabBarController;
  final controller = Get.find<GuestHomeController>();

 @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
  }

  @override
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
  }
}
