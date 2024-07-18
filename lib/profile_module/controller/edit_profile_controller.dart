import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/profile_module/service/profile_serice.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../model/user_model.dart';

class EditProfileController extends BaseController {
  final nameTextController = TextEditingController();
  final emailController = TextEditingController();
  RxnString errorNameText = RxnString(null);
  UserModel userModel = UserModel();
  final profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    getUserData(initial: true);
  }

  void onNameChanged(String name) {
    if (GetUtils.isAlphabetOnly(name)) {
      errorNameText.value = null;
    } else {
      errorNameText.value = 'Enter valid name';
    }
  }

  Future<void> getUserData({required bool initial}) async {
    final response = await profileService.userDataApi();
    if (response != null) {
      userModel = response;
      update();
    }
  }

  void updateDateOfBirth({required String dateOfBirth}) {
    userModel.dateOfBirth = dateOfBirth;
    update();
  }

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

      cancelDialog();
      update();
    }
  }

  Future<void> updateUserData() async {
    if (errorNameText.value != null) {
      showSnackBar(context: Get.context!, message: 'Please enter name');
      return;
    } else if (userModel.dateOfBirth == null) {
      showSnackBar(context: Get.context!, message: 'Please select date of birth');
      return;
    }
    userModel.firstName = nameTextController.text;

    showLoaderDialog(context: Get.context!);
    final response = await profileService.updateUserDataApi(firstName: 'Shubham',email: 'sktech9@gmail.com');
    if (response != null) {
      userModel = response;
      update();
    }
    cancelDialog();
    //Get.offAllNamed(RoutesConst.dashboardScreen);
  }

  @override
  void onClose() {
    nameTextController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
