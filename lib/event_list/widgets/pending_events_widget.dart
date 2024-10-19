import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/event_list/controller/event_list_controller.dart';

import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';

class PendingEventsWidget extends StatelessWidget {
  final List<EventResponseModel> eventsList;

  const PendingEventsWidget({super.key, required this.eventsList});

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
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: errorColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 210,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: cachedImage(
                                    height: 200, width: screenWidth * 0.81, imageUrl: data.coverImage ?? ""),
                              ),
                              Positioned.fill(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                                    child: Container(
                                      height: 25,
                                      width: 200,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: darkGreyColor.withOpacity(0.8), borderRadius: BorderRadius.circular(5)),
                                      child: Text(
                                        data.eventName ?? '',
                                        style: textStyleAleo(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RoutesConst.createdEventPreviewScreen, arguments: data);
                                  },
                                  child: const ClipRRect(
                                    child: Icon(
                                      Icons.info_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (data.hasWishes != null && data.hasWishes == false) {
                                  controller.navigateToEventDecorations(
                                      eventResponseModel: data, eventDecorations: EventDecorations.wishes);
                                }
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: data.hasWishes != null && data.hasWishes! ? greenTextColor : Colors.grey,
                                child: const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Wishes',
                              style: textStyleDangrek(
                                  color: data.hasWishes != null && data.hasWishes! ? greenTextColor : Colors.grey,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (data.hasPersonalWishes != null && data.hasPersonalWishes == false) {
                                  controller.navigateToEventDecorations(
                                      eventResponseModel: data, eventDecorations: EventDecorations.personalWishes);
                                }
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: data.hasPersonalWishes != null && data.hasPersonalWishes!
                                    ? greenTextColor
                                    : Colors.grey,
                                child: const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Personal Wishes',
                              style: textStyleDangrek(
                                  color: data.hasPersonalWishes != null && data.hasPersonalWishes! ? greenTextColor : Colors.grey,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (data.hasGifts != null && data.hasGifts == false) {
                                  controller.navigateToEventDecorations(
                                      eventResponseModel: data, eventDecorations: EventDecorations.eGifts);
                                }
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor:
                                data.hasGifts != null && data.hasGifts! ? greenTextColor : Colors.grey,
                                child: const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Gifts',
                              style: textStyleDangrek(
                                  color: data.hasGifts != null && data.hasGifts! ? greenTextColor : Colors.grey,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCupertinoActionSheetOptions(
                              button1Text: StringConsts.deleteThisEvent,
                              onTapButton1: () {
                                controller.deleteEvent(
                                  eventId: data.eventid ?? '',
                                  eventsCreated: controller.eventsCreated,
                                  deleteForMe: true,
                                  deleteForEveryone: true,
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: errorColor, borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              'Discard',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.navigateToEventDecorations(
                                eventResponseModel: data, eventDecorations: EventDecorations.none);
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: greenTextColor, borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              'Continue event',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_rounded,
                          color: darkBlueColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          'Wishes & Personal wishes are mandatory for event.',
                          style: textStyleMontserrat(color: darkBlueColor, fontSize: 14),
                        )),
                      ],
                    )
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
