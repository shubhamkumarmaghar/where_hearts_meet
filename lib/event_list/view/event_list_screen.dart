import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/event_list/widgets/pending_events_widget.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/shimmers/event_list_shimmer.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/app_bar_widget.dart';
import '../../utils/widgets/no_data_screen.dart';
import '../controller/event_list_controller.dart';
import '../widgets/event_list_widget.dart';

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
                  height: screenHeight * 0.06,
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
                                  : controller.eventsCreated == EventsCreated.forUser
                                      ? StringConsts.noEventsCreatedForYou
                                      : StringConsts.noPendingEvents,
                            ),
                          )
                        : controller.eventsCreated == EventsCreated.pending
                            ? PendingEventsWidget(eventsList: controller.eventsList ?? [])
                            : EventsListWidget(
                                eventsList: controller.eventsList ?? [],
                              ),
              ],
            ),
          ),
        );
      },
    );
  }
}
