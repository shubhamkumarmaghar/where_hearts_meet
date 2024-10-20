import 'dart:async';
import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:heart_e_homies/utils/consts/string_consts.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';

class EventHomeController extends BaseController {
  late ConfettiController homeConfettiController;
  late EventResponseModel eventDetails;
  RxString infoText = RxString('');
  final _eventService = ViewEventService();
  late String eventId;
  late EventsCreated eventsCreated;
  List<WishesModel>? wishesList;
  late UserType userType;
  RxBool descriptionVisible = false.obs;
  RxBool canUpdateGifts = false.obs;
  RxBool canShowWishes = false.obs;

  @override
  void onInit() {
    super.onInit();
    homeConfettiController = ConfettiController(duration: const Duration(minutes: 1));
    homeConfettiController.play();
    final repo = locator<CreatedEventRepo>();
    eventDetails = repo.getCurrentEvent ?? EventResponseModel();
    eventId = eventDetails.eventid ?? '';
    eventsCreated = repo.getCurrentEventCreated ?? EventsCreated.byUser;
    userType = repo.getUserType ?? UserType.registered;
    log('Event Details :: ${eventDetails.toJson()}  -- UserType :: $userType  -- Event Created :: $eventsCreated');
    if (eventsCreated == EventsCreated.byUser) {
      canUpdateGifts.value = true;
    }
    if (eventDetails.eventDescription != null && eventDetails.eventDescription!.trim().isNotEmpty) {
      descriptionVisible.value = true;
      showDescription(eventDetails.eventDescription!);
    }
    getEventWishes(eventId);
  }

  void showDescription(String description) async {
    final List<String> list = description.split('');
    String showInfo = '';
    for (var data in list) {
      showInfo = '$showInfo$data';
      await Future.delayed(const Duration(milliseconds: 60));
      infoText.value = showInfo;
    }
  }

  Future<void> getEventWishes(String eventId) async {
    var res = await _eventService.fetchWishesList(eventId: eventId);
    wishesList = res ?? [];
    update();
  }

  @override
  void onClose() {
    homeConfettiController.dispose();
    super.onClose();
  }
}
