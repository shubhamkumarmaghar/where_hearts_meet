import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/utils/controller/base_controller.dart';

import '../../create_event/model/event_response_model.dart';

class CreatedEventPreviewController extends BaseController {
  late EventResponseModel eventResponseModel;

  final eventNameController = TextEditingController();

  final nameController = TextEditingController();

  final personMobileController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final model = Get.arguments as EventResponseModel?;
    eventResponseModel = model ?? EventResponseModel();
    eventNameController.text = eventResponseModel.eventName ?? '';
    nameController.text = eventResponseModel.receiverName ?? '';
    personMobileController.text = eventResponseModel.receiverPhoneNumber ?? '';
    descriptionController.text = eventResponseModel.eventDescription ?? '';
  }

  @override
  void onClose() {
    eventNameController.dispose();
    nameController.dispose();
    personMobileController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
