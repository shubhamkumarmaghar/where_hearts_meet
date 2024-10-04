import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heart_e_homies/utils/extensions/methods_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/event_type_model.dart';
import '../../utils/model/week_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../model/event_model.dart';
import '../service/create_event_service.dart';
import '../widgets/create_event_widgets.dart';

class CreateEventController extends BaseController {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 7); // Set your birthday date here
  TimeOfDay selectedTime = TimeOfDay.now();

  Duration countdownDuration = Duration();
  Timer? countdownTimer;
  String? backgroundImage;
  String? coverImage;
  RxBool isEventDateSelected = false.obs;
  RxBool isEventTimeSelected = false.obs;
  RxBool createButtonEnabled = false.obs;
  EventModel eventModel = EventModel();
  WeekModel? weekModel;
  final createEventService = CreateEventService();

  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final eventTypeController = TextEditingController();
  final personMobileController = TextEditingController();
  final descriptionController = TextEditingController();

  EventTypeModel selectedEventType =
      EventTypeModel(eventName: StringConsts.eventType, eventTypeId: '0', eventIcon: Icons.select_all);

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    if (data != null) {
      try {
        selectedEventType = data as EventTypeModel;
        eventTypeController.text = selectedEventType.eventName ?? '';
      } catch (e) {
        log(e.toString());
      }
    }
    _setEventTime();
  }

  void selectDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      selectedDate = date.at(selectedTime);
      isEventDateSelected = true.obs;
      _setEventTime(selectedDate: date);
      updateCreateButtonStatus();
      _updateTimer();
    }
  }

  void updateCreateButtonStatus() {
    if (backgroundImage != null && isEventDateSelected.value) {
      createButtonEnabled.value = true;
    } else {
      createButtonEnabled.value = false;
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      selectedTime = pickedTime;
      isEventTimeSelected = true.obs;
      selectedDate = selectedDate.at(selectedTime);
      _setEventTime(selectedDate: selectedDate);
      _updateTimer();
    }
  }

  void _setEventTime({DateTime? selectedDate}) {
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
    eventModel.eventHostDay = dateTime.toIso8601String();
  }

  void _updateTimer() {
    countdownDuration = selectedDate.difference(DateTime.now());
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        countdownDuration = selectedDate.difference(DateTime.now());
        update();
      },
    );
  }

  void selectEventSheet() async {
    final event = await showEventsTypeBottomSheet();
    if (event != null) {
      selectedEventType = event;
      eventTypeController.text = selectedEventType.eventName ?? '';
      update();
    }
  }

  void selectImage(EventImageType eventImageType) {
    showImagePickerDialog(
      context: Get.context!,
      onCamera: () => _onCaptureImage(source: ImageSource.camera, imageType: eventImageType),
      onGallery: () => _onCaptureImage(source: ImageSource.gallery, imageType: eventImageType),
    );
  }

  void _onCaptureImage({required ImageSource source, required EventImageType imageType}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source);
    if (image != null) {
      final croppedImage = await cropImage(filePath: image.path);
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          if (imageType == EventImageType.backgroundImage) {
            eventModel.splashBackgroundImage = imageResponse.fileId;
            backgroundImage = imageResponse.fileUrl;
            updateCreateButtonStatus();
          } else if (imageType == EventImageType.coverImage) {
            eventModel.coverImage = imageResponse.fileId;
            coverImage = imageResponse.fileUrl;
          }

          update();
        }
      }
    }
  }

  Future<void> createEvent() async {
    if (isEventDateSelected.value && isEventTimeSelected.value) {
      showLoaderDialog(context: Get.context!);
      final response = await createEventService.createEventApi(eventModel: eventModel);
      cancelDialog();
      if (response != null) {
        var createdEvent = locator<CreatedEventRepo>();
        createdEvent.setEvent(response);
        Get.offNamed(RoutesConst.createWishesScreen);
      }
    } else {
      AppWidgets.getToast(message: 'Select event timing');
    }
  }

  void navigateToCreateEventSplashScreen() {
    if (nameController.text.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter person's name", color: errorColor);
      return;
    }
    if (eventNameController.text.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter event name", color: errorColor);
      return;
    }
    if (personMobileController.text.isEmpty || personMobileController.text.length != 10) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Enter valid phone number", color: errorColor);
      return;
    }
    final mobile = GetStorage().read(userMobile) ?? '';
    if (mobile == personMobileController.text) {
      AppWidgets.showSnackBar(
          context: Get.context!, message: "Receiver & Sender mobile number can not be same! ", color: errorColor);
      return;
    }
    if (eventTypeController.text.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Select event's type", color: errorColor);
      return;
    }
    if (coverImage == null || coverImage!.isEmpty) {
      AppWidgets.showSnackBar(context: Get.context!, message: "Add cover image", color: errorColor);
      return;
    }

    eventModel.receiverName = nameController.text;
    eventModel.eventName = eventNameController.text;
    eventModel.receiverPhoneNumber = personMobileController.text;
    eventModel.eventType = eventTypeController.text;
    eventModel.eventDescription = descriptionController.text;
    var createdEvent = locator<CreatedEventRepo>();
    createdEvent.clearRepo();

    Get.toNamed(RoutesConst.createEventSplashScreen);
  }

  void deleteFile({required String imageUrl, required EventImageType imageType}) async {
    showLoaderDialog(context: Get.context!);

    final response = await createEventService.deleteFileApi(fileUrl: imageUrl);
    cancelDialog();
    if (response) {
      if (imageType == EventImageType.coverImage) {
        coverImage = null;
        eventModel.coverImage = null;
      } else if (imageType == EventImageType.backgroundImage) {
        backgroundImage = null;
        eventModel.splashBackgroundImage = null;
      }
      update();
    }
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    nameController.dispose();
    eventNameController.dispose();
    eventTypeController.dispose();
    personMobileController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
