import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/create_event/model/personal_wishes_model.dart';
import 'package:where_hearts_meet/create_event/widgets/create_event_widgets.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';
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
  ImageResponseModel? backgroundImage;
  final createEventService = CreateEventService();
  final titleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    var createdEvent = locator<CreatedEventRepo>();
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
        showLoaderDialog(context: Get.context!);
        final imageResponse = await createEventService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null) {
          backgroundImage = imageResponse;
          update();
        }
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
    if(backgroundImage == null ){
      AppWidgets.getToast(message: 'Add cover image');
      return;
    }

    showLoaderDialog(context: Get.context!);
    final model = PersonalWishesModel(
        eventId: eventResponseModel.eventid, message: titleController.text, coverImage: backgroundImage?.fileId);
    final response = await createEventService.addPersonalWishesApi(model: model);
    cancelDialog();
    if (response != null) {
      navigateToCreatePersonalMemoriesScreen();
    }
  }

  void navigateToCreatePersonalMemoriesScreen() {
    Get.offAllNamed(
      RoutesConst.createPersonalMemoriesScreen,
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
