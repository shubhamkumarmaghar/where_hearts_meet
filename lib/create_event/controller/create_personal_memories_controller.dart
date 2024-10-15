import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/color_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../../utils/widgets/util_widgets/app_widgets.dart';
import '../model/event_response_model.dart';
import '../model/personal_memories_model.dart';
import '../model/personal_wishes_model.dart';
import '../service/create_event_service.dart';

class CreatePersonalMemoriesController extends BaseController {
  late EventResponseModel eventResponseModel;
  RxString nextButtonTitle = StringConsts.next.obs;
  List<PersonalMemoriesModel> memoriesList = [];
  RxBool submitButtonEnabled = true.obs;
  final createEventService = CreateEventService();
  ImageResponseModel? memoryImage;
  ImageResponseModel? memoryVideo;
  final memoryText = TextEditingController();
  late Future<PersonalWishesModel?> Function() createPersonalCover;
  late bool forEdit;
  late Map<String, dynamic>? coverScreenData;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments as Map<String, dynamic>;
    coverScreenData = arg;
    var createdEvent = locator<CreatedEventRepo>();
    eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
    forEdit = createdEvent.actions == AppActions.edit;
  }

  void _selectDestination(MediaType mediaType) {
    showImagePickerDialog(
      context: Get.context!,
      title: mediaType == MediaType.image ? StringConsts.uploadImage : StringConsts.uploadVideo,
      onCamera: () => mediaType == MediaType.image
          ? _onCaptureImage(source: ImageSource.camera)
          : _onCaptureVideo(source: ImageSource.camera),
      onGallery: () => mediaType == MediaType.image
          ? _onCaptureImage(source: ImageSource.gallery)
          : _onCaptureVideo(source: ImageSource.gallery),
    );
  }

  void _onCaptureVideo({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var video = await picker.pickVideo(
      source: source,
    );
    final videoFile = File(video?.path ?? '');

    if (video != null) {
      showLoaderDialog(context: Get.context!);
      final videoResponse = await createEventService.uploadVideoApi(videoFile: videoFile);
      cancelDialog();
      if (videoResponse != null) {
        memoryImage = null;
        memoryVideo = videoResponse;
        update();
      }
    }
  }

  void _onCaptureImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, imageQuality: 80);

    if (image != null) {
      final croppedImage = await cropImage(
        filePath: image.path,
      );
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          memoryImage = imageResponse;
          memoryVideo = null;
          update();
        }
      }
    }
  }

  void deleteFile({required MediaType mediaType, required String fileUrl}) async {
    showLoaderDialog(context: Get.context!);

    final response = await createEventService.deleteFileApi(fileUrl: fileUrl);
    cancelDialog();
    if (response) {
      if (mediaType == MediaType.image) {
        memoryImage = null;
      } else if (mediaType == MediaType.video) {
        memoryVideo = null;
      }
      update();
    }
  }

  void showCupertinoActionSheet() {
    if (memoryVideo == null && memoryImage == null) {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                _selectDestination(MediaType.image);
              },
              child: const Text(
                StringConsts.photo,
                style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
                _selectDestination(MediaType.video);
              },
              child: const Text(
                StringConsts.video,
                style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            isDefaultAction: true,
            child: const Text(
              StringConsts.cancel,
              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
    } else {
      AppWidgets.getToast(message: 'Delete the current image/video.', color: errorColor);
    }
  }

  void onNext() {
    if (memoriesList.isNotEmpty) {
      if (forEdit) {
        Get.offNamed(RoutesConst.createPersonalMessagesScreen);
      } else {
        Get.offAllNamed(RoutesConst.createPersonalMessagesScreen);
      }
    } else {
      AppWidgets.getToast(message: 'Please add at least 1 memory', color: redColor);
    }
  }

  void viewMemories() {
    Get.toNamed(RoutesConst.createdMemoriesPreviewScreen, arguments: memoriesList);
  }

  Future<bool?> addPersonalCover() async {
    if (coverScreenData != null) {
      final text = coverScreenData!['text'];
      final image = coverScreenData!['image'] as File;

      final imageResponse = await createEventService.uploadImageApi(imageFile: image);
      if (imageResponse != null) {
        final model =
            PersonalWishesModel(eventId: eventResponseModel.eventid, message: text, coverImage: imageResponse.fileId);
        final coverResponse = await createEventService.addPersonalWishesApi(model: model);
        return coverResponse != null;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void submitMemories() async {
    if (memoryImage == null && memoryVideo == null) {
      AppWidgets.getToast(message: 'Add photo or video', color: errorColor);
      return;
    }
    PersonalMemoriesModel model = PersonalMemoriesModel();
    model.description = memoryText.text;

    model.eventId = eventResponseModel.eventid;
    if (memoryImage != null) {
      model.file = memoryImage?.fileId;
      model.fileType = 'image';
    } else {
      model.file = memoryVideo?.fileId;
      model.fileType = 'video';
    }

    if (memoriesList.isEmpty) {
      showLoaderDialog(context: Get.context!);
      final coverResponse = await addPersonalCover();
      if (coverResponse != null && coverResponse) {
        final response = await createEventService.addPersonalMemoriesApi(model: model);
        cancelDialog();
        if (response != null) {
          memoriesList.add(response);
          memoryImage = null;
          memoryVideo = null;
          memoryText.clear();
          nextButtonTitle = StringConsts.next.obs;
          update();
        }
      } else {
        cancelDialog();
      }
    } else {
      showLoaderDialog(context: Get.context!);
      final response = await createEventService.addPersonalMemoriesApi(model: model);
      cancelDialog();
      if (response != null) {
        memoriesList.add(response);
        memoryImage = null;
        memoryVideo = null;
        memoryText.clear();
        nextButtonTitle = StringConsts.next.obs;
        update();
      }
    }
  }

  @override
  void onClose() {
    memoryText.dispose();
    super.onClose();
  }
}
