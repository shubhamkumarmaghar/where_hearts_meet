import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/screens/login_screen.dart';
import 'package:where_hearts_meet/dashboard_module/controller/dashboard_controller.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_drawer_screen.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/model/event_info_model.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/widgets/event_card.dart';
import '../../utils/model/user_info_model.dart';
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
            title: const Text('Home'),
            actions: [
              Container(margin: EdgeInsets.only(right: _mainWidth * 0.04), child: const Icon(Icons.notifications))
            ],
          ),
          drawer: DashboardDrawerScreen(),
          body: Container(
            height: _mainHeight,
            width: _mainWidth,
            color: whiteColor,
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
                    height: _mainHeight * 0.12,
                    child: NeumorphicButton(
                      onPressed: () {
                      Get.toNamed(RoutesConst.loginScreen);
                      },
                      style: NeumorphicStyle(
                        color: greyColor.withOpacity(0.1),
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      child: Icon(
                        Icons.event,
                        size: _mainHeight * 0.05,
                        color: primaryColor,
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
                    height: _mainHeight * 0.12,
                    child: NeumorphicButton(
                      onPressed: () {
                        Get.toNamed(RoutesConst.editProfileScreen);
                      },
                      style: NeumorphicStyle(
                        color: greyColor.withOpacity(0.1),
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      child: Icon(
                        Icons.add_reaction,
                        size: _mainHeight * 0.1,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                  Row(
                    children: const [
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
                  SizedBox(
                    height: _mainHeight * 0.25,
                    child: getEventsCard(context: context, controller: controller, eventsList: [
                      EventInfoModel(
                          imageUrl:
                              'https://wishes.moonzori.com/wp-content/uploads/2022/06/Happy-Birthday-Wishes-Moonzori.png',
                          id: 101,
                          eventName: 'Birthday'),
                      EventInfoModel(
                          imageUrl:
                              'https://img.freepik.com/free-vector/miss-you-sticky-note-illustration_53876-8270.jpg?w=2000',
                          id: 103,
                          eventName: 'Miss You'),
                      EventInfoModel(
                          imageUrl: 'https://m.media-amazon.com/images/I/8191XGqO7uL.jpg',
                          id: 102,
                          eventName: 'Just Surprise'),
                    ]),
                  ),
                  SizedBox(
                    height: _mainHeight * 0.04,
                  ),
                  Row(
                    children: const [
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
                  SizedBox(
                    height: _mainHeight * 0.25,
                    child: getUsersCard(context: context, controller: controller, usersList: [
                      UserInfoModel(
                          imageUrl:
                              'https://wishes.moonzori.com/wp-content/uploads/2022/06/Happy-Birthday-Wishes-Moonzori.png',
                          id: 101,
                          name: 'Hannah'),
                      UserInfoModel(
                          imageUrl:
                              'https://img.freepik.com/free-vector/miss-you-sticky-note-illustration_53876-8270.jpg?w=2000',
                          id: 103,
                          name: 'Lessie'),
                      UserInfoModel(
                          imageUrl: 'https://m.media-amazon.com/images/I/8191XGqO7uL.jpg', id: 102, name: 'Jennie'),
                    ]),
                  ),
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
      required List<EventInfoModel> eventsList,
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
          return Stack(
            children: [
              EventCard(
                onCardTap: () {},
                eventInfoModel: data,
                eventColor: getColorBasedOnIndex(index),
              ),
              // ConfettiView(
              //   controller: controller.eventConfettiController,
              //   confettiShapeEnum: ConfettiShapeEnum.drawStar,
              // ),
            ],
          );
        });
  }

  Widget getUsersCard(
      {required BuildContext context,
      required List<UserInfoModel> usersList,
      required DashboardController controller}) {
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
                userInfoModel: data,
                eventColor: getColorBasedOnIndex(index),
              ),
              // ConfettiView(
              //   controller: controller.eventConfettiController,
              //   confettiShapeEnum: ConfettiShapeEnum.drawStar,
              // ),
            ],
          );
        });
  }
}
