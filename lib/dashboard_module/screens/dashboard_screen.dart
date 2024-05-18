import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/controller/dashboard_controller.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_drawer_screen.dart';
import 'package:where_hearts_meet/profile_module/model/people_model.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';
import 'package:where_hearts_meet/utils/widgets/event_card.dart';
import '../../create_event_module/model/add_event_model.dart';
import '../../utils/buttons/buttons.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/mini_user_card.dart';

class DashboardScreen extends StatelessWidget {
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title:  Center(child: Image.asset(logo, height: 80,width: 80,)),
            actions: [
              Container(margin: EdgeInsets.only(right: _mainWidth * 0.04), child: const Icon(Icons.notifications))
            ],
          ),
          drawer: DashboardDrawerScreen(dashboardController: controller),
          body: Container(
            height: _mainHeight,
            width: _mainWidth,
            color: appColor5,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Event',
                    style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.02,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: getIconButton(
                      onPressed: () {
                        Get.toNamed(RoutesConst.addEventScreen, arguments: ScreenName.fromDashboard);
                      },
                      child: Icon(
                        Icons.add_photo_alternate,
                        size: _mainHeight * 0.06,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                  const Text(
                    'Add People',
                    style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.02,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: getIconButton(
                      onPressed: () async{
                       Get.toNamed(RoutesConst.addPeopleScreen);
                      },
                      child: Icon(
                        Icons.add_reaction,
                        size: _mainHeight * 0.06,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Favourite Event\'s  \u{1F970} ',
                        style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                      Spacer(),
                      Text('View all events'),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                  Obx(() {
                    return SizedBox(
                      height: _mainHeight * 0.25,
                      child: controller.showEventView.value
                          ? getEventsCard(context: context, controller: controller, eventsList: controller.currentUserEventList)
                          : const Center(child: CircularProgressIndicator()),
                    );
                  }),
                  SizedBox(
                    height: _mainHeight * 0.04,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Favourite People\'s  \u{1F929} ',
                        style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                      Spacer(),
                      Text('View all people'),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                  Obx(() {
                    return SizedBox(
                      height: _mainHeight * 0.25,
                      child: controller.showPeopleView.value
                          ? getUsersCard(context: context, controller: controller, usersList: controller.peopleList)
                          : const Center(child: CircularProgressIndicator()),
                    );
                  }),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getEventsCard(
      {required BuildContext context,
      required List<AddEventModel> eventsList,
      required DashboardController controller}) {
    return GridView.builder(
        //cacheExtent: 9999,
        itemCount: eventsList.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: _mainWidth / (_mainHeight * 0.75),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          var data = eventsList[index];
          return EventCard(
            onCardTap: () {
              Get.toNamed(RoutesConst.eventDetailsScreen, arguments: data);
            },
            eventInfoModel: data,
            eventColor: getColorBasedOnIndex(index),
          );
        });
  }

  Widget getUsersCard(
      {required BuildContext context, required List<PeopleModel> usersList, required DashboardController controller}) {
    return GridView.builder(
        //cacheExtent: 9999,
        itemCount: usersList.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: _mainWidth / (_mainHeight * 0.36),
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
}
