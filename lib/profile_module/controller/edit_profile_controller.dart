import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/profile_module/service/profile_serice.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../model/user_model.dart';

class EditProfileController extends BaseController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  RxnString errorNameText = RxnString(null);
  UserModel userModel = UserModel();
  final profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    getUserData(initial: true);
    firstNameController.text  = 'Deepak';
    lastNameController.text = 'Rockx';
    addressController.text = 'New Delhi';
    emailController.text = 'deepak424@gmail.com';
    mobileController.text ='9889617848';
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

    userModel.firstName = firstNameController.text;

    showLoaderDialog(context: Get.context!);

    final response = await profileService.updateUserDataApi(
      firstName: 'SkTech',
      email: 'sktech@gmail.com',
      gender: 'Male',
      lastName: 'Kumar',
      address: 'Delhi',
      dateOfBirth: '27/04/2000',
      martialStatus: 'Unmarried',
      profilePic: '',
    );
    if (response != null) {
      userModel = response;
      update();
    }
    cancelDialog();
    //Get.offAllNamed(RoutesConst.dashboardScreen);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}
