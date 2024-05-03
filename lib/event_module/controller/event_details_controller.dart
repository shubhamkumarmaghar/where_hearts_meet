
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/event_module/model/add_event_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class EventDetailsController extends BaseController {
  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final infoController = TextEditingController();
  late AddEventModel eventDetails;

  late ConfettiController confettiController;
  RxString infoText = RxString('');

  @override
  void onInit() {
    super.onInit();
    confettiController = ConfettiController(duration: const Duration(hours: 1));
    confettiController.play();
    final arg = Get.arguments;
    if (arg != null) {
      eventDetails = arg as AddEventModel;
      show();
    }
  }

  void show() async {
    final info = eventDetails.eventInfo ?? '';
    final List<String> list = info.split(' ');
    String showInfo = '';
    for (var data in list) {
      showInfo = '$showInfo $data';
      await Future.delayed(const Duration(milliseconds: 700));
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
