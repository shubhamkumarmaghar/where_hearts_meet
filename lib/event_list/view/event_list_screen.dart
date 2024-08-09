import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/event_list/controller/event_list_controller.dart';
import 'package:where_hearts_meet/utils/consts/string_consts.dart';
import 'package:where_hearts_meet/utils/extensions/string_extension.dart';
import 'package:where_hearts_meet/utils/shimmers/event_list_shimmer.dart';
import 'package:where_hearts_meet/utils/widgets/app_bar_widget.dart';
import 'package:where_hearts_meet/utils/widgets/cached_image.dart';
import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/no_data_screen.dart';
import '../../utils/widgets/pop_up_menus.dart';

class EventListScreen extends StatelessWidget {
  final controller = Get.find<EventListController>();

  EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventListController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    backIcon(),
                    const Spacer(),
                    Text(
                      controller.pageTitle,
                      style: textStyleDangrek(fontSize: 24),
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                controller.eventsList == null
                    ? const EventListShimmer()
                    : controller.eventsList != null && controller.eventsList!.isEmpty
                        ? NoDataScreen(
                            message: controller.eventsCreated == EventsCreated.byUser
                                ? StringConsts.noEventsCreatedByYou
                                : StringConsts.noEventsCreatedForYou,
                          )
                        : _eventInfoCardsWidget(
                            eventsList: controller.eventsList ?? [],
                          ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _eventInfoCardsWidget({required List<EventResponseModel> eventsList}) {
    return SizedBox(
      height: screenHeight * 0.85,
      width: screenWidth,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var data = eventsList[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(RoutesConst.guestCoverScreen,
                  arguments: data.eventid, parameters: {'type': controller.forSelf == true ? 'For You' : 'By You'});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => CustomPhotoView(
                          imageUrl: data.coverImage,
                        ));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          child: cachedImage(height: 200, width: screenWidth, imageUrl: data.coverImage ?? "")),
                      Positioned(
                          right: 10,
                          top: 10,
                          child: moreViewPopUpMenu(onDelete: () {
                            controller.deleteEvent(eventId: data.eventid ?? "");
                          }, onView: () {
                            Get.toNamed(RoutesConst.guestCoverScreen,
                                arguments: data.eventid,
                                parameters: {'type': controller.forSelf == true ? 'For You' : 'By You'});
                          })),
                      Positioned(
                        right: screenWidth * 0.15,
                        bottom: screenHeight * 0.01,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => CustomPhotoView(
                                  imageUrl: data.splashBackgroundImage,
                                ));
                          },
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenHeight * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white, width: 3)),
                            //padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: cachedImage(imageUrl: data.splashBackgroundImage),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.01,
                        bottom: screenHeight * 0.01,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => CustomPhotoView(
                                  imageUrl: data.splashDisplayImage,
                                ));
                          },
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenHeight * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white, width: 3)),
                            //padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: cachedImage(imageUrl: data.splashDisplayImage),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth * 0.6,
                      child: Text(
                        data.eventName.isNotNullOrEmpty ? data.eventName!.capitalizeFirst.toString() : '',
                        style: textStyleDangrek(fontSize: screenWidth * 0.055),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      width: screenWidth * 0.25,
                      child: Text(
                        data.eventType ?? '',
                        style: textStyleDangrek(fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.55,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Lucky one : ${controller.forSelf ? 'You' : '${data.receiverName}'}",
                        style: textStyleDangrek(fontSize: 18),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      getYearTime(data.eventHostDay ?? ''),
                      style: textStyleDangrek(fontSize: 18),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: screenWidth * 0.8,
                  child: Text(
                    "From : ${!controller.forSelf ? 'You' : '${data.hostName}'}",
                    style: textStyleDangrek(fontSize: 16),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Column(
          children: [
            SizedBox(
              height: screenHeight * 0.015,
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            SizedBox(
              height: screenHeight * 0.015,
            )
          ],
        ),
        itemCount: eventsList.length,
      ),
    );
  }
}
