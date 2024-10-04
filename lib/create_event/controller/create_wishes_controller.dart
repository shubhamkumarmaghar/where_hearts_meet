import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import '../model/wishes_model.dart';
import '../service/create_event_service.dart';

class CreateWishesController extends BaseController {
  late EventResponseModel eventResponseModel;
  List<WishesModel> wishesList = [];
  final nameTextController = TextEditingController();
  final messageTextController = TextEditingController();
  List<ImageResponseModel> imagesList = [];
  List<ImageResponseModel> videosList = [];
  ImageResponseModel? profileImage;
  late bool forEdit;

  final createEventService = CreateEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
    forEdit = createdEvent.actions == AppActions.edit;
  }

  void uploadSenderImage() {
    if (profileImage == null) {
      showImagePickerDialog(
        context: Get.context!,
        title: StringConsts.uploadImage,
        onCamera: () => _uploadProfileImage(source: ImageSource.camera),
        onGallery: () => _uploadProfileImage(source: ImageSource.gallery),
      );
    } else {
      showCupertinoActionSheetOptions(
          button1Text: 'Delete Image',
          button2Text: 'Update Image',
          onTapButton1: () async {
            showLoaderDialog(context: Get.context!);
            final response = await createEventService.deleteFileApi(fileUrl: profileImage?.fileUrl ?? '');
            cancelDialog();
            if (response) {
              profileImage = null;
              update();
            }
          },
          onTapButton2: () {
            showImagePickerDialog(
              context: Get.context!,
              title: StringConsts.uploadImage,
              onCamera: () => _uploadProfileImage(source: ImageSource.camera),
              onGallery: () => _uploadProfileImage(source: ImageSource.gallery),
            );
          });
    }
  }

  void _uploadProfileImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, imageQuality: 70);

    if (image != null) {
      final croppedImage = await cropImage(filePath: image.path, isProfileImage: true);
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        if (imageResponse != null) {
          if (profileImage != null) {
            await createEventService.deleteFileApi(fileUrl: profileImage?.fileUrl ?? '', showMsg: false);
            cancelDialog();
            profileImage = imageResponse;
            update();
          } else {
            cancelDialog();
            profileImage = imageResponse;
            update();
          }
        } else {
          cancelDialog();
        }
      }
    }
  }

  void uploadMedia({required MediaType mediaType}) {
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

  void _onCaptureImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, imageQuality: 80);

    if (image != null) {
      final croppedImage = await cropImage(filePath: image.path);
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          imagesList.add(imageResponse);
          update();
        }
      }
    }
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
        videosList.add(videoResponse);
        update();
      }
    }
  }

  void deleteFile({required int index, required MediaType mediaType}) async {
    showLoaderDialog(context: Get.context!);

    String fileUrl = '';
    if (mediaType == MediaType.image) {
      fileUrl = imagesList[index].fileUrl ?? '';
    } else if (mediaType == MediaType.video) {
      fileUrl = videosList[index].fileUrl ?? '';
    }

    final response = await createEventService.deleteFileApi(fileUrl: fileUrl);
    cancelDialog();
    if (response) {
      if (mediaType == MediaType.image) {
        imagesList.removeAt(index);
      } else if (mediaType == MediaType.video) {
        videosList.removeAt(index);
      }
      update();
    }
  }

  void addWishes() async {
    showLoaderDialog(context: Get.context!);
    final response = await createEventService.addWishesEventApi(
        wishesModel: WishesModel(
            eventId: eventResponseModel.eventid,
            imageUrls: imagesList.map((model) => model.fileId ?? '').toList(),
            videoUrls: videosList.map((model) => model.fileId ?? '').toList(),
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

  void navigateToCreatedWishesPreviewScreen(WishesModel wishesModel) async {
    final res = await Get.toNamed(
      RoutesConst.createdWishesPreviewScreen,
      arguments: wishesModel,
    );
    if (res != null) {
      try {
        final wishId = res as int;
        wishesList.removeWhere((element) => element.id == wishId);
        update();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void navigateToPersonalWishesScreen() {
    if (wishesList.isNotEmpty) {
      if (forEdit) {
        Get.offNamed(
          RoutesConst.createPersonalCoverScreen,
        );
      } else {
        Get.offAllNamed(
          RoutesConst.createPersonalCoverScreen,
        );
      }
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
