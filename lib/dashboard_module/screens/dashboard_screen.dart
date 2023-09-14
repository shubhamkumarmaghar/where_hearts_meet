import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/controller/dashboard_controller.dart';
import 'package:where_hearts_meet/dashboard_module/screens/dashboard_drawer_screen.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/model/event_info_model.dart';
import 'package:where_hearts_meet/utils/widgets/mini_event_card.dart';

import '../../utils/consts/confetti_shape_enum.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/confetti_view.dart';

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
              actions: [Container(margin: EdgeInsets.only(right: _mainWidth * 0.04), child: const Icon(Icons.notifications))],
            ),
            drawer: DashboardDrawerScreen(),
            body: Container(
              height: _mainHeight,
              width: _mainWidth,
              color: whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Your Event\'s  \u{1F970} ',
                        style: TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                      Spacer(),
                      Text('View all'),
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
                    child: getEventCard(context: context,controller: controller, eventList: [
                      EventInfoModel(
                          imageUrl:
                          'https://wishes.moonzori.com/wp-content/uploads/2022/06/Happy-Birthday-Wishes-Moonzori.png',
                          id: 101,
                          eventName: 'Birthday'),
                      EventInfoModel(
                          imageUrl: 'https://m.media-amazon.com/images/I/8191XGqO7uL.jpg',
                          id: 102,
                          eventName: 'Just Surprise'),
                      EventInfoModel(
                          imageUrl:
                          'https://img.freepik.com/free-vector/miss-you-sticky-note-illustration_53876-8270.jpg?w=2000',
                          id: 103,
                          eventName: 'Miss You')
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
                      Text('View all'),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: _mainHeight * 0.025,
                  ),
                ],
              ),
            ),
          );
        },);
  }

  Widget getEventCard({required BuildContext context, required List<EventInfoModel> eventList,required DashboardController controller}) {
    return GridView.builder(
        //cacheExtent: 9999,
        itemCount: eventList.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: _mainWidth / (_mainHeight * 0.36),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          var data = eventList[index];
          return Stack(
            children: [
              MiniEventCard(
                onCardTap: () {},
                eventInfoModel: data,
                eventColor: getColorBasedOnIndex(index),
              ),
              ConfettiView(
                controller: controller.eventConfettiController,
                confettiShapeEnum: ConfettiShapeEnum.drawStar,
              ),
            ],
          );
        });
  }
}
