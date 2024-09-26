import 'package:flutter/material.dart';
import 'package:heart_e_homies/utils/widgets/pop_up_menus.dart';
import '../../create_event/model/event_response_model.dart';
import '../consts/app_screen_size.dart';
import '../consts/color_const.dart';
import '../consts/screen_const.dart';
import '../util_functions/decoration_functions.dart';
import 'cached_image.dart';

class EventCard extends StatelessWidget {
  final EventResponseModel eventResponseModel;
  final Function onCardTap;
  final Function onDelete;
  final Function onShare;
  final EventsCreated eventsCreated;

  const EventCard(
      {Key? key,
      required this.eventResponseModel,
      required this.onCardTap,
      required this.onDelete,
      required this.eventsCreated,
      required this.onShare})
      : super(key: key);

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
              //height: screenHeight * 0.25,
              width: screenWidth * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: cachedImage(
                    imageUrl: eventResponseModel.coverImage, height: 190, width: 190),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Text(
                eventResponseModel.eventName ?? '',
                style: textStyleDangrek(fontSize: screenWidth * 0.055),
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
                style: textStyleDangrek(fontSize: screenWidth * 0.046),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.white, width: 3)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: cachedImage(imageUrl: eventResponseModel.splashBackgroundImage),
                  ),
                ),
                eventsCreated == EventsCreated.byUser
                    ? moreViewPopUpMenu(onDelete: onDelete, onShare: onShare, showBackground: false)
                    : moreViewPopUpMenu(onDelete: onDelete, showBackground: false),
              ],
            )
          ],
        ),
      ),
    );
  }
}
