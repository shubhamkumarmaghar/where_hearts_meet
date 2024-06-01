import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/show_event_module/model/event_details_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../create_event_module/model/add_event_model.dart';
import '../service/show_event_service.dart';

class EventDetailsController extends BaseController {
  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final infoController = TextEditingController();
  EventDetailsModel? eventDetails;

  late ConfettiController confettiController;
  RxString infoText = RxString('');

  final showEventService = ShowEventApiService();

  Future<void> getEventDetails(String eventId) async {
    setBusy(true);
    eventDetails = await showEventService.getEventDetails(eventId: eventId);
    setBusy(false);
    showDescription();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    confettiController = ConfettiController(duration: const Duration(hours: 1));
    confettiController.play();
    final arg = Get.arguments;
    if (arg != null) {
      getEventDetails(arg);
    }
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
  void dispose() {
    nameController.dispose();
    eventNameController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    infoController.dispose();
    super.dispose();
  }
}
