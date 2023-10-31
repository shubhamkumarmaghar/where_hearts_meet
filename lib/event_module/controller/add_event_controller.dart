import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/event_module/model/add_event_model.dart';
import 'package:where_hearts_meet/profile_module/controller/add_people_controller.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';

import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../../utils/services/firebase_storage_controller.dart';

class AddEventController extends BaseController {
  final nameController = TextEditingController();
  final eventNameController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final infoController = TextEditingController();
  String imageUrl = '';
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  final peopleController = Get.find<AddPeopleController>();

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
      final firebaseStorageController = Get.find<FirebaseStorageController>();
      final url = await firebaseStorageController.uploadEventPic(file: imageFile, eventName: eventNameController.text);
      imageUrl = url;
      cancelLoaderDialog();
      update();
    }
  }

  Future<void> addEvent() async {
    showLoaderDialog(context: Get.context!);
    await fireStoreController.addEvent(
        addEventModel: AddEventModel(
            imageUrl: imageUrl,
            name: nameController.text,
            eventName: eventNameController.text,
            text1: titleController.text,
            text2: subtitleController.text,
            text3: infoController.text,
            fromEmail: firebaseAuthController.getCurrentUser()?.email,
            toEmail: peopleController.selectedUser?.email));
    cancelLoaderDialog();
    Get.offAllNamed(RoutesConst.dashboardScreen);
  }

  @override
  void dispose() {
    nameController.dispose();
    eventNameController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    infoController.dispose();
    super.dispose();
  }
}
