
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';

import '../../utils/consts/service_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../model/wishes_model.dart';
import '../service/create_event_service.dart';

class CreateWishesController extends BaseController {
  late EventResponseModel eventResponseModel;
  List<WishesModel> wishesList = [];
  final nameTextController = TextEditingController();
  final messageTextController = TextEditingController();
  List<ImageResponseModel> imagesList = [];
  List<String> videosList = [];
  ImageResponseModel? profileImage;

  final createEventService = CreateEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    if (createdEvent.getCurrentEvent != null) {
      eventResponseModel = createdEvent.getCurrentEvent!;
    }
  }

  void onCaptureMediaClick({required ImageSource source, bool? forProfile}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(
        source: source, maxHeight: 800, maxWidth: 800, imageQuality: forProfile != null && forProfile ? 40 : 75);

    if (image != null) {
      final croppedImage = await cropImage(filePath: image.path, isProfileImage: forProfile);
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          if (forProfile != null && forProfile) {
            profileImage = imageResponse;
          } else {
            imagesList.add(imageResponse);
          }

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

  void addWishes() async {
    showLoaderDialog(context: Get.context!);
    final response = await createEventService.addWishesEventApi(
        wishesModel: WishesModel(
            eventId: eventResponseModel.eventid,
            imageUrls: imagesList.map((model) => model.fileId ?? '').toList(),
            videoUrls: videosList,
            senderMessage: messageTextController.text,
            senderName: nameTextController.text,
            senderProfileImage: profileImage?.fileId));
    cancelDialog();
    if (response != null) {
      nameTextController.clear();
      messageTextController.clear();
      profileImage = null;
      imagesList.clear();
      videosList.clear();
      wishesList.add(response);
      update();
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

  void navigateToCreatedWishesPreviewScreen(WishesModel wishesModel) {
    Get.toNamed(
      RoutesConst.createdWishesPreviewScreen,
      arguments: wishesModel,
    );
  }

  void navigateToCreateTimelineScreen() {
    if (wishesList.isNotEmpty) {
      Get.offNamed(
        RoutesConst.createTimelineScreen,
      );
    } else {
      AppWidgets.getToast(message: 'Please add at least 1 wish', color: redColor);
    }
  }
  @override
  void onClose() {
    nameTextController.dispose();
    messageTextController.dispose();
    super.onClose();
  }
}
