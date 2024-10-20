import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/event_list/controller/event_list_controller.dart';
import 'package:heart_e_homies/utils/extensions/methods_extension.dart';

import '../../create_event/model/event_response_model.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/pop_up_menus.dart';

class EventsListWidget extends StatelessWidget {
  final List<EventResponseModel> eventsList;

  const EventsListWidget({super.key, required this.eventsList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<EventListController>(
        builder: (controller) {
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.03),
            itemBuilder: (context, index) {
              var data = eventsList[index];
              return InkWell(
                onTap: () => controller.navigateToEventDetails(data),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
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
                                      button1Text: StringConsts.deleteForMe,
                                      button2Text: StringConsts.deleteForEveryone,
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
                              : controller.eventsCreated == EventsCreated.forUser
                                  ? moreViewPopUpMenu(onDelete: () {
                                      showCupertinoActionSheetOptions(
                                        button1Text: StringConsts.deleteForMe,
                                        onTapButton1: () {
                                          controller.deleteEvent(
                                              eventId: data.eventid ?? '',
                                              eventsCreated: controller.eventsCreated,
                                              deleteForEveryone: true);
                                        },
                                      );
                                    })
                                  : const SizedBox.shrink(),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: GestureDetector(
                            onTap: () {
                              controller.wishlistEvent(data.eventid ??'');
                            },
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            ),
                          ),
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
                          //  "${StringConsts.luckyOne} : ${controller.forSelf ? StringConsts.you : '${data.receiverName}'}",
                            "${StringConsts.luckyOne} : ${data.receiverName}",
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
                       // "${StringConsts.from} : ${!controller.forSelf ? StringConsts.you : '${data.hostName}'}",
                      "${StringConsts.from} : ${data.hostName}",
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
          );
        },
      ),
    );
  }
}
