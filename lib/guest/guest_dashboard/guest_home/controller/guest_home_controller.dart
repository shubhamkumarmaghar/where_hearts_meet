import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../show_event_module/model/event_details_model.dart';
import '../../../../utils/controller/base_controller.dart';
import '../service/guest_receive_event.dart';

class GuestHomeController extends BaseController {
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  double volume = 100;
  bool muted = false;
  bool isPlayerReady = false;
  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  DateTime birthday = DateTime(2024, 7, 17); // Set your birthday date here
  Duration countdownDuration = Duration();
  Timer? countdownTimer;

  late ConfettiController homeConfettiController;
  EventDetailsModel? eventDetails;
  RxBool isLoading = true.obs;
  RxString infoText = RxString('');
  GuestReceiveService _guestReceiveService = GuestReceiveService();
  @override
  void onInit() {
    super.onInit();
    homeConfettiController = ConfettiController(duration: const Duration(minutes: 1));
    homeConfettiController.play();
    final arg = Get.arguments;
    // if (arg != null) {
    //   getEventDetails(arg);
    // }
  }

  Future<void> getEventDetails(String eventId) async {
    setBusy(true);
    eventDetails = await _guestReceiveService.getEventDetails(eventId: eventId, mobileNo: '9989142678');
    setBusy(false);
    showDescription();
    update();
  }

  void showDescription() async {
    final info = eventDetails?.eventDescription ?? '';
    final List<String> list = info.split('');
    String showInfo = '';
    for (var data in list) {
      showInfo = '$showInfo$data';
      await Future.delayed(const Duration(milliseconds: 60));
      infoText.value = showInfo;
    }
  }

  void startCountdown() {
    countdownDuration = birthday.difference(DateTime.now());
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
        countdownDuration = birthday.difference(DateTime.now());
    });
    update();
  }
  @override
  void onClose() {
    homeConfettiController.dispose();
    super.onClose();
  }
}