import 'dart:developer';

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
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String imageUrl4 = '';
  String imageUrl5 = '';
  String imageUrl6 = '';
  RxInt selectedImage = RxInt(1);
  RxString selectedImageUrl = RxString('');

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
      setImage();
    }
  }

  void show() async {
    final info = eventDetails.eventInfo ?? '';
    final List<String> list = info.split(' ');
    String showinfo = '';
    for (var data in list) {
      showinfo = showinfo + ' ' + data;
      await Future.delayed(Duration(milliseconds: 700));
      infoText.value = showinfo;
    }
  }

  void setImage() {
    if (eventDetails.imageList != null) {
      var imageListCount = eventDetails.imageList!.length;
      selectedImageUrl.value = eventDetails.imageList![0] ?? '';
      if (imageListCount == 1) {
        imageUrl1 = eventDetails.imageList![0] ?? '';
      }
      if (imageListCount == 2) {
        imageUrl1 = eventDetails.imageList![0] ?? '';
        imageUrl2 = eventDetails.imageList![1] ?? '';
      }
      if (imageListCount == 3) {
        imageUrl1 = eventDetails.imageList![0] ?? '';
        imageUrl2 = eventDetails.imageList![1] ?? '';
        imageUrl3 = eventDetails.imageList![2] ?? '';
      }
      if (imageListCount == 4) {
        imageUrl1 = eventDetails.imageList![0] ?? '';
        imageUrl2 = eventDetails.imageList![1] ?? '';
        imageUrl3 = eventDetails.imageList![2] ?? '';
        imageUrl4 = eventDetails.imageList![3] ?? '';
      }
      if (imageListCount == 5) {
        imageUrl1 = eventDetails.imageList![0] ?? '';
        imageUrl2 = eventDetails.imageList![1] ?? '';
        imageUrl3 = eventDetails.imageList![2] ?? '';
        imageUrl4 = eventDetails.imageList![3] ?? '';
        imageUrl5 = eventDetails.imageList![4] ?? '';
      }
      if (imageListCount == 6) {
        imageUrl1 = eventDetails.imageList![0] ?? '';
        imageUrl2 = eventDetails.imageList![1] ?? '';
        imageUrl3 = eventDetails.imageList![2] ?? '';
        imageUrl4 = eventDetails.imageList![3] ?? '';
        imageUrl5 = eventDetails.imageList![4] ?? '';
        imageUrl6 = eventDetails.imageList![5] ?? '';
      }
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
