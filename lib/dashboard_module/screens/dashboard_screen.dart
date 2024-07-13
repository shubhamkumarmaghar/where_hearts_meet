import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/dashboard_module/controller/dashboard_controller.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_drawer_screen.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/model/dropdown_model.dart';
import 'package:where_hearts_meet/utils/repository/wishes_card_data.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';
import 'package:where_hearts_meet/utils/widgets/base_container.dart';
import 'package:where_hearts_meet/utils/widgets/event_card.dart';
import '../../create_event_module/model/add_event_model.dart';
import '../../utils/buttons/buttons.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/mini_user_card.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          // drawer: DashboardDrawerScreen(dashboardController: controller),
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(gradient: dashboardBackgroundGradient
                // image: DecorationImage(
                //   image: AssetImage(dashboardBackground),
                //   fit: BoxFit.cover,
                // ),
                ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight * 0.08,
                        child: Image.asset(
                          logo,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Text(
                        'Heart-e-homies',
                        style: GoogleFonts.aclonica(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.6),
                                offset: Offset(-6.0, -6.0),
                                blurRadius: 16.0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                offset: Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.dashboard,
                            color: primaryColor,
                            size: 24,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Deepak !',
                              style: GoogleFonts.abel(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            Text(
                              "Wish your loved ones.",
                              style: GoogleFonts.abel(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        Container(
                          height: screenHeight * 0.065,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/5231/5231019.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  getDateView(controller: controller),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Schedule an Event',
                      style: dashboardHeadingStyle,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: scheduleEventView(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Wish your loved one's on",
                      style: dashboardHeadingStyle,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  getWishesCard(context: context, wishesList: getWishesCardsDataList(), controller: controller)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget scheduleEventView() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesConst.addEventScreen, arguments: ScreenName.fromDashboard);
      },
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.25,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://static.vecteezy.com/system/resources/previews/037/335/170/large_2x/ai-generated-pastel-and-aqua-balloons-with-confetti-on-purple-background-free-photo.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned.fill(
            bottom: screenHeight * 0.02,
            right: screenWidth * 0.04,
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                child: Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.35,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.celebration,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getDateView({required DashboardController controller}) {
  return Container(
    height: screenHeight * 0.07,
    width: screenWidth,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var data = controller.currentWeekDates[index];
          bool isCurrentDay = controller.isCurrentDay(currentDay: data.date);

          return Container(
            width: screenWidth * 0.11,
            decoration: BoxDecoration(
                color: isCurrentDay ? primaryColor : whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: isCurrentDay ? null : Border.all(color: primaryColor.withOpacity(0.4), width: 0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.date,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14, color: isCurrentDay ? whiteColor : Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.day.substring(0, 3),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14, color: isCurrentDay ? whiteColor : Colors.black),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              width: screenWidth * 0.025,
            ),
        itemCount: controller.currentWeekDates.length),
  );
}

Widget getWishesCard(
    {required BuildContext context, required List<DropDownModel> wishesList, required DashboardController controller}) {
  return Container(
    height: screenHeight * 0.4,
    width: screenWidth,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: wishesList.length,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.1, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          var data = wishesList[index];
          return Container(
            height: screenHeight * 0.15,
            width: screenWidth * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage(data.value ?? ''), fit: BoxFit.cover)),
          );
        }),
  );
}

Widget getUsersCard(
    {required BuildContext context, required List<PeopleModel> usersList, required DashboardController controller}) {
  return GridView.builder(
      //cacheExtent: 9999,
      itemCount: usersList.length,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: screenWidth / (screenHeight * 0.36),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (BuildContext context, int index) {
        var data = usersList[index];
        return Stack(
          children: [
            MiniUserCard(
              onCardTap: () {},
              peopleModel: data,
              eventColor: getColorBasedOnIndex(index),
            ),
          ],
        );
      });
}
//Event\'s  \u{1F970}
