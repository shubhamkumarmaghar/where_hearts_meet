import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event/model/personal_wishes_model.dart';
import 'package:where_hearts_meet/create_event/widgets/create_event_widgets.dart';
import 'package:where_hearts_meet/splash_module/screens/splash_screen.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/confirmation_dialog.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../model/event_response_model.dart';
import '../service/create_event_service.dart';

class CreatePersonalWishesController extends BaseController {
  late EventResponseModel eventResponseModel;
  List<ImageResponseModel> imagesList = [];
  List<String> videosList = [];
  List<String> messagesList = [];
  final createEventService = CreateEventService();
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    if (createdEvent.getCurrentEvent != null) {
      eventResponseModel = createdEvent.getCurrentEvent!;
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
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          imagesList.add(imageResponse);
          log('images count :: ${imagesList.length}');
          update();
        }
      }
    }
  }

  void onCaptureVideo({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var video = await picker.pickVideo(
      source: source,
    );
    final videoFile = File(video?.path ?? '');

    if (video != null) {
      _uploadVideo(videoFile: videoFile);
    }
  }

  Future<void> _uploadVideo({required File videoFile}) async {
    showLoaderDialog(context: Get.context!);

    final url = await createEventService.uploadVideoToAws(videoFile: videoFile);

    cancelDialog();
    if (url.isNotEmpty) {
      videosList.add(url);
      update();
    }
  }

  void onMessagesTap() async {
    final message = await showTextDialog(dialogTitle: 'Wish/Message', hintText: 'Add your wish/message');
    if (message != null && message.trim().isNotEmpty) {
      messagesList.add(message);
      update();
    }
    log('messages count :: ${messagesList.length}');
  }

  void addPersonalWishes() async {
    showLoaderDialog(context: Get.context!);
    PersonalWishesModel model = PersonalWishesModel();

    model.coverImage = '172271953865181984';
    model.eventId = eventResponseModel.eventid ?? '';
    model.images = imagesList.map((e) => e.fileId ?? '').toList();
    model.videos = videosList;
    model.wishes = messagesList;

    final response = await createEventService.addPersonalWishesEventApi(model: model);
    cancelDialog();
    if (response != null) {
      navigateToCreateGiftsScreen();
    }
  }

  void navigateToCreateGiftsScreen() {
    Get.offAllNamed(
      RoutesConst.createGiftsScreen,
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
