import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../show_event_module/model/event_details_model.dart';
import '../../../../utils/controller/base_controller.dart';
import '../service/guest_receive_event.dart';

class GuestHomeController extends BaseController {
  late ConfettiController homeConfettiController;
  EventDetailsModel? eventDetails;
  RxString infoText = RxString('');
  GuestReceiveService _guestReceiveService = GuestReceiveService();
  @override
  void onInit() {
    super.onInit();
    homeConfettiController = ConfettiController(duration: const Duration(minutes: 1));
    homeConfettiController.play();
    final arg = Get.arguments;
    if (arg != null) {
      getEventDetails(arg);
    }
  }

  Future<void> getEventDetails(String eventId) async {
    setBusy(true);
    eventDetails = await _guestReceiveService.getEventDetails(eventId: eventId, mobileNo: '1234567890');
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
  @override
  void onClose() {
    homeConfettiController.dispose();
    super.onClose();
  }
}