import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/routes_const.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/service_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../model/event_response_model.dart';
import '../model/personal_decorations_model.dart';
import '../service/create_event_service.dart';

class CreatePersonalDecorationsController extends BaseController {
  late EventResponseModel eventResponseModel;
  List<ImageResponseModel> imagesList = [];
  List<ImageResponseModel> videosList = [];

  final createEventService = CreateEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    eventResponseModel = createdEvent.getCurrentEvent ?? EventResponseModel();
  }

  void uploadMedia(MediaType mediaType) {
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

  void _onCaptureImage({
    required ImageSource source,
  }) async {
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

  void addPersonalDecoration() async {
    showLoaderDialog(context: Get.context!);
    PersonalDecorationsModel model = PersonalDecorationsModel(
        eventId: eventResponseModel.eventid.toString(),
        images: imagesList.map((model) => model.fileId ?? '').toList(),
        videos: videosList.map((model) => model.fileId ?? '').toList());
    final response = await createEventService.addPersonalDecorationsEventApi(model: model);
    cancelDialog();
    if (response != null) {
      navigateToCreateGiftScreen();
    }
  }

  void navigateToCreateGiftScreen() {
    Get.offAllNamed(RoutesConst.createGiftsScreen);
  }
}
