import 'package:flutter/material.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';

import '../util_functions/decoration_functions.dart';

class EventCard extends StatelessWidget {
  final EventResponseModel eventResponseModel;
  final Function onCardTap;

  const EventCard({Key? key, required this.eventResponseModel, required this.onCardTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCardTap();
      },
      child: Container(
        width: screenWidth * 0.55,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: appColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(200),
              topRight: Radius.circular(200),
            )),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.25,
              width: screenWidth * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: cachedImage(
                    imageUrl: eventResponseModel.coverImage, height: screenHeight * 0.25, width: screenWidth * 0.6),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.005,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Text(
                eventResponseModel.eventName ?? '',
                style: headingStyle(fontSize: screenWidth * 0.055),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Text(
                getYearTime(eventResponseModel.eventHostDay ?? ''),
                style: headingStyle(fontSize: screenWidth * 0.046),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.06,
                  child: Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.06,
                        width: screenHeight * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.white, width: 3)),
                        //padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            eventResponseModel.splashBackgroundImage ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.05,
                        child: Container(
                          height: screenHeight * 0.06,
                          width: screenHeight * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 3)),
                          //padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              eventResponseModel.splashDisplayImage ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.15,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: screenWidth * 0.02),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    'See',
                    style: headingStyle(fontSize: screenWidth * 0.04, color: primaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String getYearTime(String date) {
    if (date.isEmpty) {
      return '';
    }
    final dateTime = DateTime.parse(date);
    final time = '${addZero(dateTime.day)}/${addZero(dateTime.month)}/${dateTime.year}';
    return time;
  }

  String addZero(int value) {
    return value > 9 ? value.toString() : '0$value';
  }
}
