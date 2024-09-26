import 'dart:async';
import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';

class EventHomeController extends BaseController {
  DateTime birthday = DateTime.now(); // Set your birthday date here
  Duration countdownDuration = Duration();
  Timer? countdownTimer;
  final _eventService = ViewEventService();
  late ConfettiController homeConfettiController;
  late EventResponseModel eventDetails;
  RxString infoText = RxString('');
  late String eventId;
  late EventsCreated eventsCreated;
  List<WishesModel> wishesList = [];
  late UserType userType;

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
    getData();
    log('Event Details :: ${eventDetails.toJson()}  -- UserType :: $userType  -- Event Created :: $eventsCreated');
  }

  Future<void> getData() async {
    startCountdown();
    getEventWishes(eventId);
    update();
  }

  Future<void> getEventWishes(String eventId) async {
    var response = await _eventService.fetchWishesList(eventId: eventId);
    if (response != null) {
      wishesList = response;
    }
    update();
  }

  void showDescription() async {
    final info = eventDetails.eventDescription ?? '';
    final List<String> list = info.split('');
    String showInfo = '';
    for (var data in list) {
      showInfo = '$showInfo$data';
      await Future.delayed(const Duration(milliseconds: 60));
      infoText.value = showInfo;
    }
  }

  Future<void> startCountdown() async {
    if (birthday.isAfter(DateTime.now())) {
      countdownDuration = birthday.difference(DateTime.now());
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        countdownDuration = birthday.difference(DateTime.now());
      });
    } else {
      countdownDuration = birthday.difference(birthday);
    }
    update();
  }
}
