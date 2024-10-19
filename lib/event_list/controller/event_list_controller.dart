import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/consts/service_const.dart';
import 'package:heart_e_homies/utils/repository/created_event_repo.dart';
import '../../create_event/model/event_response_model.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/confirmation_dialog.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../service/event_list_service.dart';

class EventListController extends BaseController {
  final _eventListService = EventListService();
  List<EventResponseModel>? eventsList;
  late EventsCreated eventsCreated;
  late String pageTitle;
  late bool forSelf;

  @override
  void onInit() {
    super.onInit();
    eventsCreated = Get.arguments as EventsCreated;
    if (eventsCreated == EventsCreated.forUser) {
      pageTitle = 'Received Events';
      eventsListCreatedForUser();
      forSelf = true;
    } else if (eventsCreated == EventsCreated.byUser) {
      pageTitle = 'Created Events';
      eventsListCreatedByUser();
      forSelf = false;
    } else if (eventsCreated == EventsCreated.wishlist) {
      pageTitle = 'Wishlist';
      getWishListedEvents();
      forSelf = false;
    } else {
      pageTitle = 'Pending Events';
      pendingEventsCreatedByUser();
      forSelf = false;
    }
  }

  void navigateToEventDetails(EventResponseModel eventResponseModel) {
    final repo = locator<CreatedEventRepo>();
    repo.setEvent(eventResponseModel);
    repo.setEventCreated(eventsCreated);
    repo.setUserType(UserType.registered);

    Get.toNamed(RoutesConst.eventCoverScreen);
  }

  void navigateToEventDecorations(
      {required EventResponseModel eventResponseModel, required EventDecorations eventDecorations}) async {
    final repo = locator<CreatedEventRepo>();
    repo.setEvent(eventResponseModel);
    repo.setEventCreated(eventsCreated);
    repo.setUserType(UserType.registered);
    repo.setAppActions(AppActions.edit);

    if (eventDecorations == EventDecorations.wishes) {
      await Get.toNamed(RoutesConst.createWishesScreen);
    } else if (eventDecorations == EventDecorations.personalWishes) {
      await Get.toNamed(RoutesConst.createPersonalCoverScreen);
    } else if (eventDecorations == EventDecorations.eGifts) {
      await Get.toNamed(RoutesConst.createGiftsScreen);
    } else if (eventDecorations == EventDecorations.none) {
      if (eventResponseModel.hasWishes != null && eventResponseModel.hasWishes == false) {
        await Get.toNamed(RoutesConst.createWishesScreen);
      } else if (eventResponseModel.hasPersonalWishes != null && eventResponseModel.hasPersonalWishes == false) {
        await Get.toNamed(RoutesConst.createPersonalCoverScreen);
      }
    }
    pendingEventsCreatedByUser();
  }

  Future<void> eventsListCreatedByUser() async {
    final response = await _eventListService.fetchEventsList(EventsCreated.byUser);
    if (response != null && response.isNotEmpty) {
      eventsList = response;
    } else {
      eventsList = [];
    }
    update();
  }

  Future<void> getWishListedEvents() async {
    final response = await _eventListService.fetchEventsList(EventsCreated.wishlist);
    if (response != null && response.isNotEmpty) {
      eventsList = response;
    } else {
      eventsList = [];
    }
    update();
  }

  Future<void> pendingEventsCreatedByUser() async {
    final response = await _eventListService.fetchEventsList(EventsCreated.pending);
    if (response != null && response.isNotEmpty) {
      eventsList = response;
    } else {
      eventsList = [];
    }
    update();
  }

  Future<void> eventsListCreatedForUser() async {
    final response = await _eventListService.fetchEventsList(EventsCreated.forUser);
    if (response != null && response.isNotEmpty) {
      eventsList = response;
    } else {
      eventsList = [];
    }
    update();
  }

  Future<void> wishlistEvent(String eventId) async {
    showLoaderDialog(context: Get.context!);
    final response = await _eventListService.wishListEvent(eventId);
    cancelDialog();
  }

  void deleteEvent(
      {required String eventId,
      required EventsCreated eventsCreated,
      bool? deleteForMe,
      bool? deleteForEveryone}) async {
    showLoaderDialog(context: Get.context!);
    final res = await _eventListService.deleteEventApi(
        eventId: eventId, deleteForMe: deleteForMe, deleteForEveryone: deleteForEveryone);
    cancelDialog();
    if (res != null) {
      eventsList?.removeWhere((element) => element.eventid == eventId);
    }
    update();
  }
}
