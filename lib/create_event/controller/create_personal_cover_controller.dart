import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/consts/color_const.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../model/event_response_model.dart';
import '../model/personal_wishes_model.dart';
import '../service/create_event_service.dart';
import '../widgets/create_event_widgets.dart';

class CreatePersonalCoverController extends BaseController {
  late EventResponseModel eventResponseModel;
  File? imageFile;
  final createEventService = CreateEventService();
  final titleController = TextEditingController();
  late bool forEdit;

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    forEdit = createdEvent.actions == AppActions.edit;
    if (createdEvent.getCurrentEvent != null) {
      eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
    }
  }

  void onCaptureMediaClick({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, maxHeight: 800, maxWidth: 800, imageQuality: 80);

    if (image != null) {
      final croppedImage = await cropImage(
        filePath: image.path,
      );
      if (croppedImage != null) {
        imageFile = File(croppedImage.path);
        update();
      }
    }
  }

  void onMessagesTap() async {
    final message = await showTextDialog(dialogTitle: 'Title', hintText: 'Add your title');
    if (message != null && message.trim().isNotEmpty) {
      titleController.text = message;
      update();
    }
  }

  void addPersonalWishesCover() async {
    if (imageFile == null) {
      AppWidgets.getToast(message: 'Add cover image', color: errorColor);
      return;
    }
    Map<String, dynamic> data = {'text': titleController.text, 'image': imageFile};
    Get.toNamed(RoutesConst.createPersonalMemoriesScreen, arguments: data);
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
