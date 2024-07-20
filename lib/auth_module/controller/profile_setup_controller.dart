import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/auth_module/auth_model/login_response_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/model/user_info_model.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';
import 'package:where_hearts_meet/utils/services/firebase_storage_controller.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/routes/routes_const.dart';

import '../auth_model/login_response_model.dart';
import '../auth_services/Auth_api_service.dart';
import '../profile_setup_const.dart';
import '../screens/add_location_page.dart';
import '../screens/add_name_page.dart';
import '../screens/add_profile_picture_page.dart';

class ProfileSetupController extends BaseController {
  AuthApiService _authApiService = AuthApiService();
  int pageIndex = 1;
  LoginResponseModel loginResponseModel = LoginResponseModel();
  final nameTextController = TextEditingController();
  final birthDateTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  RxnString errorNameText = RxnString(null);
  RxnString errorMobileText = RxnString(null);
  Rx<String> dateOfBirth = 'Date of birth'.obs;
  //final signUpController = Get.find<SignUpController>();
  String imageUrl = '';

  void onNameChanged(String name) {
    if (name.length > 2 && GetUtils.isAlphabetOnly(name)) {
      errorNameText.value = null;
    } else {
      errorNameText.value = 'Enter valid name';
    }
  }

  void onMobileChanged(String mobile) {
    if (GetUtils.isPhoneNumber(mobile)) {
      errorMobileText.value = null;
    } else {
      errorMobileText.value = 'Enter valid mobile number';
    }
  }

  void onChangePageIndex(int index) {
    pageIndex = index;
    update();
  }

  void completeSignUp() async {
    if (pageIndex == CompleteProfilePageIndex.addProfilePicturePage) {
      showLoaderDialog(context: Get.context!);
      final response = await _authApiService.SignUpUser(
        // email: signUpController.emailTextController.text,
        email: 'deepak.513770@gmail.com',
        date_of_birth: birthDateTextController.text,
        firstName: nameTextController.text.toString(),
        profile_pic: imageUrl,
        address: 'Keshavpuram',
        city: 'Keshavpuram',
        state: 'Delhi',
        country: 'India',
        lastName: '',
        phoneNumber: mobileTextController.text,
        maritalStatus: 'Single',
        postalCode: '311035',
        gender: 'male',
        //username: await GetStorage().read(username),
      );
      cancelDialog();
      loginResponseModel = response;
      if (loginResponseModel.message == 'Signup Successful') {
        await Future.wait([
          GetStorage().write(token, loginResponseModel.data?.accessToken),
          GetStorage().write(userMobile, loginResponseModel.data?.phoneNumber),
          GetStorage().write(username, loginResponseModel.data?.username),
          GetStorage().write(email, loginResponseModel.data?.email),
          GetStorage().write(profileUrl, loginResponseModel.data?.profilePic)
        ]);
        Get.offAllNamed(RoutesConst.dashboardScreen);
      }
    } else {
      onChangePageIndex(++pageIndex);
    }
  }

  void onBack() {
    if (pageIndex > 1) {
      onChangePageIndex(--pageIndex);
    } else {
      Get.back();
    }
  }

  Widget getPage() {
    switch (pageIndex) {
      case CompleteProfilePageIndex.addNamePage:
        return AddNamePage(
          controller: this,
        );
      case CompleteProfilePageIndex.addLocationPage:
        return AddLocationPage(
          controller: this,
        );
      case CompleteProfilePageIndex.addProfilePicturePage:
        return AddProfilePicturePage(
          controller: this,
        );
    }
    return const SizedBox.shrink();
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
      final firebaseStorageController = Get.find<FirebaseStorageController>();
      final url = await firebaseStorageController.uploadPic(file: imageFile);
      imageUrl = url;
      cancelDialog();
      update();
    }
  }

  @override
  void dispose() {
    nameTextController.dispose();
    birthDateTextController.dispose();
    mobileTextController.dispose();
    super.dispose();
  }
}
