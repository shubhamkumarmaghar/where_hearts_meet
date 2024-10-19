import 'dart:async';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heart_e_homies/create_event/model/event_response_model.dart';
import 'package:heart_e_homies/utils/consts/screen_const.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';
import 'package:heart_e_homies/view_event_details/service/view_event_service.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/consts/shared_pref_const.dart';
import '../../../utils/repository/created_event_repo.dart';

class EventCoverController extends BaseController {
  DateTime birthday = DateTime.now(); // Set your birthday date here
  Duration countdownDuration = Duration();
  Timer? countdownTimer;
  late EventResponseModel eventDetails;

  String textTitle = '';
  String nameText = '';
  String eventId = '';
  late EventsCreated eventsCreated;
  late UserType userType;
  final now = DateTime.now();
  DateTime today = DateTime.now();
  DateTime birthdayDate =DateTime.now();


  @override
  void onInit() {
    super.onInit();
    final repo = locator<CreatedEventRepo>();
    eventDetails = repo.getCurrentEvent ?? EventResponseModel();
    eventsCreated = repo.getCurrentEventCreated ?? EventsCreated.byUser;
    userType = repo.getUserType ?? UserType.registered;
    birthday = DateTime.parse(eventDetails.eventHostDay ?? DateTime.now().toString());
    birthdayDate = DateTime(birthday.year, birthday.month, birthday.day);
    today= DateTime(now.year, now.month, now.day);
    DateTime(birthday.year, birthday.month, birthday.day);
    getData();
    log('Event Details :: ${eventDetails.toJson()}  -- UserType :: $userType  -- Event Created :: $eventsCreated');
  }

  Future<void> getData() async {
    await textAnimation();
    startCountdown();
    update();
  }

  Future<void> textAnimation() async {
    String? text = eventDetails.eventName;
    List<String>? wordsList = text?.split('');
    for (var word in wordsList!) {
      await Future.delayed(const Duration(milliseconds: 200));
      textTitle = textTitle + word;
      update();
    }
    nameAnimation();
  }

  void nameAnimation() async {
    String? name = eventDetails.receiverName;
    List<String>? wordsList = name?.split('');
    for (var word in wordsList!) {
      await Future.delayed(const Duration(milliseconds: 200));
      nameText = nameText + word;
      update();
    }
  }

  void showDescription() async {
    final info = eventDetails.eventDescription ?? '';
    final List<String> list = info.split('');
    String showInfo = '';
    for (var data in list) {
      showInfo = '$showInfo$data';
      await Future.delayed(const Duration(milliseconds: 60));
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
