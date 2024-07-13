import 'dart:developer';
import 'dart:io';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../auth_module/controller/login_controller.dart';
import '../../auth_module/controller/profile_setup_controller.dart';
import '../../create_event_module/model/add_event_model.dart';
import '../../profile_module/model/people_model.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/week_model.dart';
import '../../utils/services/firebase_auth_controller.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../../utils/services/firebase_storage_controller.dart';
import '../../utils/util_functions/app_pickers.dart';

class DashboardController extends BaseController {
  late ConfettiController eventConfettiController;
  List<PeopleModel> peopleList = [];
  List<AddEventModel> eventList = [];
  RxBool showPeopleView = RxBool(false);
  RxBool showEventView = RxBool(false);
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseStorageController = Get.find<FirebaseStorageController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  List<AddEventModel> currentUserEventList = [];
  final _mainHeight = Get.height;
  final _mainWidth = Get.width;
  List<WeekModel> currentWeekDates = [];

  @override
  void onInit() {
    super.onInit();
    getPeopleList();
    getEventList();
    eventConfettiController = ConfettiController(duration: const Duration(hours: 1));
    eventConfettiController.play();
    getDatesForWeek();
  }

  Future<void> getPeopleList() async {
    showPeopleView.value = false;
    peopleList = await fireStoreController.getPeopleList();
    showPeopleView.value = true;
  }

  bool isCurrentDay({required String currentDay}) {
    DateTime dateTime = DateTime.now();
    final day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();
    return day == currentDay;
  }

  Future<void> getEventList() async {
    showEventView.value = false;
    List<AddEventModel> allEventList;
    final email = firebaseAuthController.getCurrentUser()?.email;
    allEventList = await fireStoreController.getEventList();
    for (var data in allEventList) {
      if (data.toEmail == email) {
        currentUserEventList.add(data);
      }
    }
    showEventView.value = true;
  }

  void showLogoutAlertDialog({String? message, required BuildContext context, required Function logOutFunction}) {
    AlertDialog alert = AlertDialog(
        content: SizedBox(
      height: _mainHeight * 0.14,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showImagePickerDialog(
                context: Get.context!,
                onCamera: () => onCaptureMediaClick(source: ImageSource.camera),
                onGallery: () => onCaptureMediaClick(source: ImageSource.gallery),
              );
            },
            child: Container(
              height: _mainHeight * 0.06,
              width: _mainWidth * 0.65,
              alignment: Alignment.center,
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: blackColor),
              child: const Text(
                'Update Image',
                style: TextStyle(color: whiteColor, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: _mainHeight * 0.02,
          ),
          InkWell(
            onTap: () {
              onDeleteMediaClick();
            },
            child: Container(
              height: _mainHeight * 0.06,
              width: _mainWidth * 0.65,
              alignment: Alignment.center,
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: blackColor),
              child: const Text(
                'Delete Image',
                style: TextStyle(color: whiteColor, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    ));
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onDeleteMediaClick() async {
    var user = firebaseAuthController.getCurrentUser();
    if (user != null && user.photoURL != null && user.photoURL != '') {
      showLoaderDialog(context: Get.context!);
      await firebaseStorageController.deleteProfilePic();
      await user.updatePhotoURL(null);
      cancelDialog();
      cancelDialog();
      update();
    } else {
      showSnackBar(context: Get.context!, message: 'Already deleted...');
    }
  }

  void onCaptureMediaClick({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
    );
    final imageFile = File(image?.path ?? '');

    if (image != null) {
      showLoaderDialog(context: Get.context!);
      final url = await firebaseStorageController.uploadPic(file: imageFile);
      if (url.isNotEmpty) {
        var user = firebaseAuthController.getCurrentUser();
        await user?.updatePhotoURL(url);
      }
      cancelDialog();
      cancelDialog();
      update();
    }
  }

  @override
  void onClose() {
    eventConfettiController.dispose();
    super.onClose();
  }

  void getDatesForWeek() {
    final DateTime dateTime = DateTime.now();

    int dayOfYear = int.parse(DateFormat("D").format(dateTime));
    int weekNumber = ((dayOfYear - dateTime.weekday + 10) / 7).floor();

    final DateTime firstDayOfYear = DateTime.utc(dateTime.year, 1, 1);
    final int firstDayOfWeek = firstDayOfYear.weekday;
    final int daysToFirstWeek = (8 - firstDayOfWeek) % 7;

    final DateTime firstDayOfGivenWeek = firstDayOfYear.add(Duration(days: daysToFirstWeek + (weekNumber - 1) * 7));
    List<WeekModel> weekList = [];
    weekList.add(WeekModel(
        date: firstDayOfGivenWeek.day < 10
            ? '0${firstDayOfGivenWeek.day.toString()}'
            : firstDayOfGivenWeek.day.toString(),
        day: DateFormat('EEEE').format(firstDayOfGivenWeek)));

    for (int i = 1; i < 7; i++) {
      final DateTime date = firstDayOfGivenWeek.add(Duration(days: i));
      weekList.add(WeekModel(
          date: date.day < 10 ? '0${date.day.toString()}' : date.day.toString(), day: DateFormat('EEEE').format(date)));
    }

    currentWeekDates = weekList;
  }
}
