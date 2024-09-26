import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/extensions/methods_extension.dart';
import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/shimmers/event_list_shimmer.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/app_bar_widget.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/no_data_screen.dart';
import '../../utils/widgets/pop_up_menus.dart';
import '../controller/event_list_controller.dart';

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
                controller.eventsList == null
                    ? const EventListShimmer()
                    : controller.eventsList != null && controller.eventsList!.isEmpty
                        ? Expanded(
                            child: NoDataScreen(
                              message: controller.eventsCreated == EventsCreated.byUser
                                  ? StringConsts.noEventsCreatedByYou
                                  : StringConsts.noEventsCreatedForYou,
                            ),
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
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.03),
        itemBuilder: (context, index) {
          var data = eventsList[index];
          return InkWell(
            onTap: () => controller.navigateToEventDetails(data),
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
                        child: controller.eventsCreated == EventsCreated.byUser
                            ? moreViewPopUpMenu(onDelete: () {
                                showCupertinoActionSheetOptions(
                                    button1Text: 'Delete for me',
                                    button2Text: 'Delete for everyone',
                                    onTapButton1: () {
                                      controller.deleteEvent(
                                          eventId: data.eventid ?? "",
                                          eventsCreated: controller.eventsCreated,
                                          deleteForMe: true);
                                    },
                                    onTapButton2: () {
                                      controller.deleteEvent(
                                        eventId: data.eventid ?? '',
                                        eventsCreated: controller.eventsCreated,
                                        deleteForMe: true,
                                        deleteForEveryone: true,
                                      );
                                    });
                              }, onShare: () {
                                shareEvent(eventModel: data, context: context);
                              })
                            : moreViewPopUpMenu(onDelete: () {
                                showCupertinoActionSheetOptions(
                                  button1Text: 'Delete for me',
                                  onTapButton1: () {
                                    controller.deleteEvent(
                                        eventId: data.eventid ?? '',
                                        eventsCreated: controller.eventsCreated,
                                        deleteForEveryone: true);
                                  },
                                );
                              }),
                      ),
                      Positioned(
                        right: screenWidth * 0.03,
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
                                border: Border.all(color: Colors.white, width: 2)),
                            //padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: cachedImage(imageUrl: data.splashBackgroundImage),
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
                        data.eventName!.isNotNullOrEmpty ? data.eventName!.capitalizeFirst.toString() : '',
                        style: textStyleDangrek(fontSize: 16),
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
                        style: textStyleAleo(fontSize: 14),
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
                        style: textStyleAleo(fontSize: 16),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      getYearTime(data.eventHostDay ?? ''),
                      style: textStyleAleo(fontSize: 16),
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
                    style: textStyleAleo(fontSize: 14),
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
