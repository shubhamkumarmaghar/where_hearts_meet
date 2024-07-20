import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

import '../../utils/consts/app_screen_size.dart';
import '../../utils/model/dropdown_model.dart';
import '../../utils/util_functions/decoration_functions.dart';
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
    },
    child: Stack(
      children: [
        SizedBox(
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
