import 'dart:developer';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/images_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/repository/wishes_card_data.dart';
import '../../utils/shimmers/event_card_shimmer.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/cached_image.dart';
import '../../utils/widgets/custom_photo_view.dart';
import '../../utils/widgets/event_card.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/dashboard_widgets.dart';
import 'dashboard_drawer_screen.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<DashboardController>();

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showExitDialog(context);
      },
      child: GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
            key: _scaffoldKey,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: primaryColor, statusBarIconBrightness: Brightness.light),
            ),
            endDrawer: DashboardDrawerScreen(
              dashboardController: controller,
              onDrawerClose: () {
                _scaffoldKey.currentState!.closeEndDrawer();
              },
            ),
            body: Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.08,
                        child: Image.asset(
                          logo,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Text(
                        'Heart-e-homies',
                        style: GoogleFonts.aclonica(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: screenWidth * 0.04),
                          child: const ClayContainer(
                            borderRadius: 50,
                            color: primaryColor,
                            height: 45,
                            width: 45,
                            child: Icon(
                              Icons.dashboard,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.userName != null && controller.userName!.isNotEmpty
                                          ? 'Hello, ${controller.userName} !'
                                          : "Hello User !",
                                      style: textStyleAbel(fontSize: 20, fontWeight: FontWeight.w600),
                                    ),
                                    Text("Wish your loved ones.",
                                        style: textStyleAbel(fontSize: 16, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Get.to(() => CustomPhotoView(
                                          imageUrl: controller.userImage,
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: cachedImage(
                                            imageUrl: controller.userImage,
                                            height: screenHeight * 0.065,
                                            width: screenHeight * 0.065)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          getDateView(controller: controller),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Schedule an Event',
                              style: dashboardtextStyleDangrek,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: scheduleEventView(),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Wish your loved one's on",
                              style: dashboardtextStyleDangrek,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          getWishesCard(context: context, wishesList: getWishesCardsDataList(), controller: controller),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'What you can do',
                              style: dashboardtextStyleDangrek,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          appFeaturesView(),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Visibility(
                            visible: controller.eventListCreatedByUser == null ||
                                (controller.eventListCreatedByUser != null &&
                                    controller.eventListCreatedByUser!.isNotEmpty),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesConst.eventListScreen, arguments: EventsCreated.byUser);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: screenHeight * 0.02),
                                child: Row(
                                  children: [
                                    Text(
                                      "Wishes created by you",
                                      style: dashboardtextStyleDangrek,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See all",
                                      style: textStyleAbel(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          controller.eventListCreatedByUser == null
                              ? const EventCardShimmer()
                              : controller.eventListCreatedByUser != null && controller.eventListCreatedByUser!.isEmpty
                                  ? const SizedBox.shrink()
                                  : SizedBox(
                                      height: 320,
                                      width: screenWidth,
                                      child: getEventCard(
                                          context: context,
                                          eventsList: controller.eventListCreatedByUser ?? [],
                                          eventsCreated: EventsCreated.byUser)),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Visibility(
                            visible: controller.eventListCreatedForUser == null ||
                                (controller.eventListCreatedForUser != null &&
                                    controller.eventListCreatedForUser!.isNotEmpty),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesConst.eventListScreen, arguments: EventsCreated.forUser);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: screenHeight * 0.02),
                                child: Row(
                                  children: [
                                    Text(
                                      "Wishes created for you",
                                      style: dashboardtextStyleDangrek,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See all",
                                      style: textStyleAbel(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          controller.eventListCreatedForUser == null
                              ? const EventCardShimmer()
                              : controller.eventListCreatedForUser != null &&
                                      controller.eventListCreatedForUser!.isEmpty
                                  ? const SizedBox.shrink()
                                  : SizedBox(
                                      height: 320,
                                      width: screenWidth,
                                      child: getEventCard(
                                          context: context,
                                          eventsList: controller.eventListCreatedForUser ?? [],
                                          eventsCreated: EventsCreated.forUser)),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getEventCard(
      {required BuildContext context,
      required List<EventResponseModel> eventsList,
      required EventsCreated eventsCreated}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            var data = eventsList[index];
            return EventCard(
              eventResponseModel: data,
              eventsCreated: eventsCreated,
              onCardTap: () {
                controller.navigateToEventDetails(eventResponseModel: data, eventsCreated: eventsCreated);
              },
              onDelete: () {
                if (eventsCreated == EventsCreated.byUser) {
                  showCupertinoActionSheetOptions(
                      button1Text: 'Delete for me',
                      button2Text: 'Delete for everyone',
                      onTapButton1: () {
                        controller.deleteEvent(
                            eventId: data.eventid ?? '', eventsCreated: eventsCreated, deleteForMe: true);
                      },
                      onTapButton2: () {
                        controller.deleteEvent(
                            eventId: data.eventid ?? '',
                            eventsCreated: eventsCreated,
                            deleteForMe: true,
                            deleteForEveryone: true);
                      });
                } else {
                  showCupertinoActionSheetOptions(
                    button1Text: 'Delete for me',
                    onTapButton1: () {
                      controller.deleteEvent(
                          eventId: data.eventid ?? '', eventsCreated: eventsCreated, deleteForEveryone: true);
                    },
                  );
                }
              },
              onShare: () {
                shareEvent(eventModel: data, context: context);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: eventsList.length > 2 ? 3 : eventsList.length),
    );
  }
}
