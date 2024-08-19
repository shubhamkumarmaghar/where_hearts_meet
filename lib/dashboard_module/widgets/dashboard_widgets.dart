import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/preview_event/widgets/videos_list_screen.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../../create_event/model/event_response_model.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/model/dropdown_model.dart';
import '../../utils/model/event_type_model.dart';
import '../../utils/repository/common_data.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/event_card.dart';
import '../controller/dashboard_controller.dart';

Widget getDrawerContentWidget({required IconData icon, required String heading, required Function onTap}) {
  return InkWell(
    onTap: () => onTap(),
    child: SizedBox(
      height: Get.height * 0.05,
      child: Row(
        children: [
          Container(
            height: Get.height * 0.04,
            width: Get.width * 0.09,
            decoration: BoxDecoration(color: appColor1.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(2),
            child: ClayContainer(
              color: appColor1,
              borderRadius: 10,
              child: Icon(
                icon,
                color: Colors.white,
                size: 17,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.04,
          ),
          Text(
            heading,
            style: textStyleDangrek(fontSize: 18),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 12,
          ),
          SizedBox(
            width: Get.width * 0.025,
          ),
        ],
      ),
    ),
  );
}

Widget scheduleEventView() {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RoutesConst.createEventScreen);
      //Get.toNamed(RoutesConst.createPersonalWishesScreen);
      // Get.toNamed(RoutesConst.createPersonalMemoriesScreen);
      //  Get.toNamed(RoutesConst.createWishesScreen);
      // Get.toNamed(RoutesConst.createGiftsScreen);
    },
    child: Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.25,
          width: screenWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              createEventImage,
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
                child: const Row(
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

Widget getDateView({required DashboardController controller}) {
  return Container(
    height: screenHeight * 0.07,
    width: screenWidth,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
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

TextStyle get dashboardtextStyleDangrek {
  return GoogleFonts.dangrek(
      decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22);
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
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.1, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          var data = wishesList[index];
          return GestureDetector(
            onTap: () {
              if (data.id == 2) {
                Get.toNamed(
                  RoutesConst.createEventScreen,
                  arguments: EventTypeModel(
                    eventName: 'Birthday',
                    eventTypeId: '2',
                  ),
                );
              } else if (data.id == 3) {
                Get.toNamed(
                  RoutesConst.createEventScreen,
                  arguments: EventTypeModel(
                    eventName: 'Congratulation',
                    eventTypeId: '3',
                  ),
                );
              } else if (data.id == 5) {
                Get.toNamed(
                  RoutesConst.createEventScreen,
                  arguments: EventTypeModel(
                    eventName: 'Anniversary',
                    eventTypeId: '5',
                  ),
                );
              } else if (data.id == 6) {
                Get.toNamed(
                  RoutesConst.createEventScreen,
                  arguments: EventTypeModel(
                    eventName: 'Wedding',
                    eventTypeId: '6',
                  ),
                );
              }
            },
            child: Container(
              height: screenHeight * 0.15,
              width: screenWidth * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage(data.value ?? ''), fit: BoxFit.cover)),
            ),
          );
        }),
  );
}

Widget appFeaturesView() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: featuresTextList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: screenHeight / (screenWidth + 100)),
        itemBuilder: (BuildContext context, int index) {
          var data = featuresTextList[index];
          return Row(
            children: [
              Expanded(
                child: ClayContainer(
                  color: appColor1,
                  borderRadius: 20,
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: appColor1,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 0.4)),
                    child: Text(
                      data,
                      style: textStyleAleo(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
  );
}
