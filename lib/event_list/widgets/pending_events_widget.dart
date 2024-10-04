import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/event_list/controller/event_list_controller.dart';
import 'package:heart_e_homies/utils/extensions/methods_extension.dart';

import '../../create_event/model/event_response_model.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';

class PendingEventsWidget extends StatelessWidget {
  final List<EventResponseModel> eventsList;
  int activeStep = 0;

  PendingEventsWidget({super.key, required this.eventsList});

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
                // onTap: () => controller.navigateToEventDetails(data),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                            height: 145,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: cachedImage(
                                      height: 135, width: screenWidth * 0.35, imageUrl: data.coverImage ?? ""),
                                ),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 25,
                                    width: 100,
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: darkBlueColor, borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      data.eventType ?? '',
                                      style: textStyleAleo(
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenWidth * 0.38,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.event,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Text(
                                      data.eventName!.isNotNullOrEmpty
                                          ? data.eventName!.capitalizeFirst.toString()
                                          : '',
                                      style: textStyleDangrek(fontSize: 16, color: primaryColor),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: screenWidth * 0.38,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Text(
                                      data.receiverName ?? '',
                                      style: textStyleAleo(fontSize: 16, color: primaryColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: screenWidth * 0.38,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Text(
                                      getYearTime(data.eventHostDay ?? ''),
                                      style: textStyleAleo(fontSize: 16, color: primaryColor),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          height: 80,
                          child: EasyStepper(
                            activeStep: activeStep,
                            stepShape: StepShape.circle,
                            showStepBorder: false,
                            stepBorderRadius: 25,
                            stepRadius: 20,
                            finishedStepBorderColor: Colors.white,
                            internalPadding: 30,
                            finishedStepTextColor: Colors.black,
                            finishedStepBackgroundColor: Colors.white,
                            activeStepIconColor: primaryColor,
                            unreachedStepTextColor: primaryColor,
                            unreachedStepIconColor: primaryColor,
                            showLoadingAnimation: false,
                            steps: [
                              EasyStep(
                                title: 'Wishes',
                                customStep: GestureDetector(
                                  onTap: () {
                                    if (data.hasWishes != null && data.hasWishes == false) {
                                      controller.navigateToEventDecorations(
                                          eventResponseModel: data, eventDecorations: EventDecorations.wishes);
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        data.hasWishes != null && data.hasWishes! ? greenTextColor : Colors.grey,
                                    child: const Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              EasyStep(
                                title: 'Personal Wishes',
                                customStep: GestureDetector(
                                  onTap: () {
                                    if (data.hasPersonalWishes != null && data.hasPersonalWishes == false) {
                                      controller.navigateToEventDecorations(
                                          eventResponseModel: data, eventDecorations: EventDecorations.personalWishes);
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: data.hasPersonalWishes != null && data.hasPersonalWishes!
                                        ? greenTextColor
                                        : Colors.grey,
                                    child: const Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              EasyStep(
                                title: 'Gifts',
                                customStep: GestureDetector(
                                  onTap: () {
                                    if (data.hasGifts != null && data.hasGifts == false) {
                                      controller.navigateToEventDecorations(
                                          eventResponseModel: data, eventDecorations: EventDecorations.eGifts);
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        data.hasGifts != null && data.hasGifts! ? greenTextColor : Colors.grey,
                                    child: const Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            enableStepTapping: false,
                            steppingEnabled: false,
                            alignment: Alignment.center,
                            onStepReached: (index) {
                              activeStep = index;
                            },
                          )),
                      const SizedBox(
                        height: 20,
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
                            'Wishes & Personal wihses are mandatory for event.',
                            style: textStyleMontserrat(color: darkBlueColor, fontSize: 14),
                          )),
                        ],
                      )
                    ],
                  ),
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
