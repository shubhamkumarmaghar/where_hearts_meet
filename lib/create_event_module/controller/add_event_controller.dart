import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/model/event_type_model.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/routes/routes_const.dart';
import '../service/create_event_service.dart';

class AddEventController extends BaseController {
  final EventApiService _eventApiService = EventApiService();
  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final eventTypeController = TextEditingController();
  final subtitleController = TextEditingController();
  final guestMobileController = TextEditingController();
  List<File> imageFiles = [];
  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 0)).obs;

  final infoController = TextEditingController();

  ScreenName? screenType;
  EventTypeModel selectedEventType =
      EventTypeModel(eventName: 'Select Event', eventTypeId: '0', eventIcon: Icons.select_all);

  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments;
    if (arg != null) {
      screenType = arg as ScreenName;
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
      imageFiles.add(imageFile);
      cancelDialog();
      update();
    }
  }

  Future<void> addEvent() async {
    if (nameController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please enter name');
      return;
    } else if (eventNameController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please enter event name');
      return;
    } else if (infoController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please enter description');
      return;
    } else if (selectedEventType.eventTypeId == '0') {
      showSnackBar(context: Get.context!, message: 'Please select event type');
      return;
    } else if (guestMobileController.text.isEmpty || guestMobileController.text.length != 10) {
      showSnackBar(context: Get.context!, message: 'Please select valid guest mobile number');
      return;
    } else if (imageFiles.isEmpty) {
      showSnackBar(context: Get.context!, message: 'Please select images for event');
      return;
    }

    List<dio.MultipartFile> eventImages = [];
    for (var image in imageFiles) {
      final img = await dio.MultipartFile.fromFile(image.path,
          filename: (image.path.split('/')).last, contentType: MediaType('image', (image.path.split('.')).last));
      eventImages.add(img);
    }

    showLoaderDialog(context: Get.context!);
    String userName = GetStorage().read(username)?.toString() ?? '';
    final response = await _eventApiService.createEvent(
        eventName: eventNameController.text.toString(),
        eventType: eventTypeController.text.toString(),
        eventDescription: infoController.text.toString(),
        eventHostDay: selectedDate.value.toUtc().toString(),
        eventSubtext: subtitleController.text.toString(),
        hostName: nameController.text.toString(),
        mobileNo: guestMobileController.text,
        username: userName,
        imageFiles: eventImages);
    cancelDialog();
    if (response.eventid != '-1') {
      Get.toNamed(RoutesConst.addEventSpecialsScreen, arguments: response);
    }
  }

  void selectEventSheet() async {
    final event = await _showEventsTypeBottomSheet();
    if (event != null) {
      selectedEventType = event;
      eventTypeController.text = selectedEventType.eventName ?? 'Others';
      update();
    }
  }

  void onSelectDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      selectedDate.value = date;
    }
  }

  Future<EventTypeModel?> _showEventsTypeBottomSheet() {
    return showModalBottomSheet<EventTypeModel>(
      context: Get.context!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            height: Get.height * 0.7,
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Select Event Type',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: screenHeight * 0.62,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = getEventsTypeList()[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop(data);
                          },
                          child: SizedBox(
                            height: screenHeight * 0.04,
                            child: Row(
                              children: [
                                Icon(
                                  data.eventIcon,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                Text(
                                  data.eventName ?? '',
                                  style:
                                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: primaryColor),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: getEventsTypeList().length),
                ),
              ],
            ));
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    eventNameController.dispose();
    subtitleController.dispose();
    infoController.dispose();
    eventTypeController.dispose();
    guestMobileController.dispose();
    super.dispose();
  }
}
