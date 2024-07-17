import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:where_hearts_meet/create_event/service/create_event_service.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/model/week_model.dart';
import 'package:where_hearts_meet/utils/routes/app_routes.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/event_type_model.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../model/event_model.dart';
import '../widgets/create_event_widgets.dart';

class CreateEventController extends BaseController {
  DateTime eventDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 7); // Set your birthday date here
  Duration countdownDuration = Duration();
  Timer? countdownTimer;
  String? backgroundImage;
  String? displayImage;
  String? coverImage;

  EventModel eventModel = EventModel();
  WeekModel? weekModel;
  final createEventService = CreateEventService();

  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final eventTypeController = TextEditingController();
  final personMobileController = TextEditingController();

  EventTypeModel selectedEventType =
      EventTypeModel(eventName: 'Select Event', eventTypeId: '0', eventIcon: Icons.select_all);

  @override
  void onInit() {
    super.onInit();
    setEventTime();
  }

  void onSelectDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: eventDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      eventDate = date;
      setEventTime(selectedDate: date);
      updateTimer();
    }
  }

  void setEventTime({DateTime? selectedDate}) {
    DateTime dateTime;
    if (selectedDate == null) {
      dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 7);
    } else {
      dateTime = selectedDate;
    }

    weekModel = WeekModel(
      day: dateTime.day.toString(),
      date: DateFormat('EEEE').format(dateTime),
      month: DateFormat('MMMM').format(DateTime(0, dateTime.month)),
    );
    eventModel.eventHostDay = dateTime.toUtc().toString();
  }

  void selectEventSheet() async {
    final event = await showEventsTypeBottomSheet();
    if (event != null) {
      selectedEventType = event;
      eventTypeController.text = selectedEventType.eventName ?? 'Others';
      update();
    }
  }

  void updateTimer() {
    countdownDuration = eventDate.difference(DateTime.now());
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      countdownDuration = eventDate.difference(DateTime.now());
      update();
    });
  }

  void onCaptureMediaClick({required ImageSource source, required EventImageType imageType}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, maxHeight: 800, maxWidth: 800, imageQuality: 50);
    if (image != null) {
      showLoaderDialog(context: Get.context!);
      final imageResponse = await createEventService.uploadImageApi(imageFile: image);
      cancelDialog();
      if (imageResponse != null) {
        if (imageType == EventImageType.backgroundImage) {
          eventModel.splashBackgroundImage = imageResponse.fileId;
          backgroundImage = imageResponse.fileUrl;
        } else if (imageType == EventImageType.displayImage) {
          eventModel.splashDisplayImage = imageResponse.fileId;
          displayImage = imageResponse.fileUrl;
        } else if (imageType == EventImageType.coverImage) {
          eventModel.coverImage = imageResponse.fileId;
          coverImage = imageResponse.fileUrl;
        }

        update();
      }
    }
  }

  void createEvent() async {
    showLoaderDialog(context: Get.context!);
    final response = await createEventService.createEventApi(eventModel: eventModel);
    cancelDialog();
    if (response != null) {
      Get.toNamed(RoutesConst.createWishesScreen, arguments: response);
    }
  }

  void navigateToCreateEventSplashScreen() {
    eventModel.receiverName = nameController.text;
    eventModel.eventName = eventNameController.text;
    eventModel.receiverPhoneNumber = personMobileController.text;
    eventModel.eventType = eventTypeController.text;

    if (eventModel.receiverName == null || eventModel.receiverName!.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter person's name", color: errorColor);
      return;
    }
    if (eventModel.eventName == null || eventModel.eventName!.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter name name", color: errorColor);
      return;
    }
    if (eventModel.receiverPhoneNumber == null || eventModel.receiverPhoneNumber!.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter person's phone number", color: errorColor);
      return;
    }
    if (eventModel.eventType == null || eventModel.eventType!.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter event's type", color: errorColor);
      return;
    }

    Get.toNamed(RoutesConst.createEventSplashScreen);
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }
}