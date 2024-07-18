import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/dashboard_module/controller/dashboard_controller.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/repository/wishes_card_data.dart';
import 'package:where_hearts_meet/utils/widgets/event_card.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../widgets/dashboard_widgets.dart';
import 'dashboard_drawer_screen.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class DashboardScreen extends StatelessWidget {
  final controller = DashboardController();

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: DashboardDrawerScreen(dashboardController: controller),
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
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
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: screenWidth * 0.04),
                        child: const ClayContainer(
                          borderRadius: 50,
                          color: primaryColor,
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.dashboard,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.84,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    controller.userName != null && controller.userName.isNotEmpty
                                        ? 'Hello, ${controller.userName} !'
                                        : "Hello User !",
                                    style: textStyleAbel(fontSize: 20, fontWeight: FontWeight.w600),
                                  ),
                                  Text("Wish your loved ones.",
                                      style: textStyleAbel(fontSize: 16, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  height: screenHeight * 0.065,
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: controller.userImage != null && controller.userImage.isNotEmpty
                                        ? Image.network(
                                            controller.userImage,
                                            fit: BoxFit.fitWidth,
                                            width: screenWidth * 0.15,
                                          )
                                        : Image.asset(
                                            profileIcon,
                                            fit: BoxFit.fitWidth,
                                            width: screenWidth * 0.15,
                                          ),
                                  ),
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
                        getWishesCard(context: context, wishesList: getWishesCardsDataList(), controller: controller),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Visibility(
                          visible: controller.eventListCreatedByUser.isNotEmpty,
                          replacement: const SizedBox.shrink(),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: screenHeight * 0.02),
                            child: Row(
                              children: [
                                Text(
                                  "Wishes created by you",
                                  style: dashboardHeadingStyle,
                                ),
                                const Spacer(),
                                Text(
                                  "See all",
                                  style: textStyleAbel(fontSize: 14,fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: screenWidth*0.01,),

                                const Icon(Icons.arrow_forward_outlined,size: 18,color: Colors.white,),
                              ],
                            ),
                          )
                        ),
                        Visibility(
                          visible: controller.eventListCreatedByUser.isNotEmpty,
                          replacement: const SizedBox.shrink(),
                          child: Container(
                              height: screenHeight * 0.44,
                              width: screenWidth,
                              padding: EdgeInsets.only(bottom: screenHeight * 0.04),
                              child: getEventCard(context: context, eventsList: controller.eventListCreatedByUser)),
                        ),
                        Visibility(
                          visible: controller.eventListCreatedForUser.isNotEmpty,
                          replacement: const SizedBox.shrink(),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: screenHeight * 0.02),
                            child: Row(
                              children: [
                                Text(
                                  "Wishes created for you",
                                  style: dashboardHeadingStyle,
                                ),
                                const Spacer(),
                                Text(
                                  "See all",
                                  style: textStyleAbel(fontSize: 14,fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: screenWidth*0.01,),

                                const Icon(Icons.arrow_forward_outlined,size: 18,color: Colors.white,),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.eventListCreatedForUser.isNotEmpty,
                          replacement: const SizedBox.shrink(),
                          child: SizedBox(
                              height: screenHeight * 0.4,
                              width: screenWidth,
                              child: getEventCard(context: context, eventsList: controller.eventListCreatedForUser)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget getEventCard({required BuildContext context, required List<EventResponseModel> eventsList}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var data = eventsList[index];
          return EventCard(eventResponseModel: data, onCardTap: () {});
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
        itemCount: eventsList.length > 2 ? 3 : eventsList.length),
  );
}
//Event\'s  \u{1F970}
