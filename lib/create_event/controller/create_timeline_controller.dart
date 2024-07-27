import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';

import '../../utils/consts/service_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/repository/created_event_repo.dart';
import '../model/event_response_model.dart';
import '../service/create_event_service.dart';

class CreateTimelineController extends BaseController {
  late EventResponseModel eventResponseModel;
  List<ImageResponseModel> imagesList = [];
  List<String> videosList = [];

  final createEventService = CreateEventService();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
    if (createdEvent.getCurrentEvent != null) {
      eventResponseModel = createdEvent.getCurrentEvent!;
    }
  }

  void onCaptureMediaClick({
    required ImageSource source,
  }) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, maxHeight: 800, maxWidth: 800, imageQuality: 70);

    if (image != null) {
      showLoaderDialog(context: Get.context!);
      final imageResponse = await createEventService.uploadImageApi(imageFile: File(image.path));
      cancelDialog();
      if (imageResponse != null) {
        imagesList.add(imageResponse);

        update();
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

  void addTimelineStories() async {
    showLoaderDialog(context: Get.context!);
    final response = await createEventService.addTimelineStoriesEventApi(
        eventId: eventResponseModel.eventid.toString(),
        imagesList: imagesList.map((model) => model.fileId ?? '').toList(),
        videosList: videosList);
    cancelDialog();
    if (response != null) {
      Get.offAllNamed(RoutesConst.createPersonalWishesScreen);
    }
  }
}
