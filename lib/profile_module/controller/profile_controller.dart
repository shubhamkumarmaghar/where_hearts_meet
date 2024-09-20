import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/routes_const.dart';
import '../../utils/consts/app_screen_size.dart';
import '../../utils/consts/screen_const.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/consts/string_consts.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/dialogs/select_data_dialog.dart';
import '../../utils/repository/user_data.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../../utils/util_functions/decoration_functions.dart';
import '../model/user_model.dart';
import '../service/profile_service.dart';

class ProfileController extends BaseController {
  UserModel userModel = UserModel();
  final _profileService = ProfileService();
  final firstNameTextController = TextEditingController();
  final lastNmeTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  LoadingState loadingState = LoadingState.loading;
  RxBool isDataChanged = false.obs;
  DateTime _initialDateTime = DateTime.now().subtract(Duration(days: 365));
  late Screens screens;

  @override
  void onInit() {
    super.onInit();
    screens = Get.arguments as Screens;
    if (screens == Screens.fromDashboard) {
      getUserData();
    } else {
      loadingState = LoadingState.hasData;
      isDataChanged = true.obs;
      phoneTextController.text = GetStorage().read(userMobile);
      update();
    }
  }

  Future<void> getUserData() async {
    loadingState = LoadingState.loading;
    update();
    final response = await _profileService.userDataApi();
    if (response != null) {
      userModel = response;
      firstNameTextController.text = userModel.firstName ?? '';
      lastNmeTextController.text = userModel.lastName ?? '';
      emailTextController.text = userModel.email ?? '';
      userModel.dateOfBirth = getYearTime(userModel.dateOfBirth);
      addressTextController.text = userModel.address ?? '';
      phoneTextController.text = userModel.phoneNumber ?? '';
      _parseDOB();
      loadingState = LoadingState.hasData;
      update();
    } else {
      loadingState = LoadingState.noData;
      update();
    }
  }

  Future<void> selectGender() async {
    final res = await selectDataDialog(
        context: Get.context!, title: StringConsts.selectGender, dataList: gendersList, height: screenHeight * 0.25);
    if (res != null) {
      if (screens == Screens.fromDashboard) {
        isDataChanged = true.obs;
      }

      userModel.gender = res.title;
      update();
    }
  }

  Future<void> selectMaritalStatus() async {
    final res = await selectDataDialog(
        context: Get.context!,
        title: StringConsts.selectMaritalStatus,
        dataList: maritalStatusList,
        height: screenHeight * 0.25);
    if (res != null) {
      if (screens == Screens.fromDashboard) {
        isDataChanged = true.obs;
      }
      userModel.maritalStatus = res.title;
      update();
    }
  }

  void updateProfilePic() {
    showImagePickerDialog(
      context: Get.context!,
      onCamera: () => _onCaptureMediaClick(
        source: ImageSource.camera,
      ),
      onGallery: () => _onCaptureMediaClick(
        source: ImageSource.gallery,
      ),
    );
  }
  void onSelectDOB() async {
    final date = await dateOfBirthPicker(context: Get.context!, initialDate: _initialDateTime);

    if (date != null) {
      isDataChanged.value = true;
      userModel.dateOfBirth = getYearTime(date.toString());
      update();
    }
  }

  void _parseDOB() {
    if (userModel.dateOfBirth != null && userModel.dateOfBirth!.isNotEmpty) {
      try {
        _initialDateTime = DateTime.parse(userModel.dateOfBirth!);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void _onCaptureMediaClick({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    var image = await picker.pickImage(source: source, imageQuality: 100);

    if (image != null) {
      final croppedImage = await cropImage(filePath: image.path, isProfileImage: true);
      if (croppedImage != null) {
        showLoaderDialog(context: Get.context!);
        final imageResponse = await _profileService.uploadImageApi(imageFile: croppedImage);
        cancelDialog();
        if (imageResponse != null && imageResponse.fileUrl != null && imageResponse.fileUrl!.isNotEmpty) {
          userModel.profilePic = imageResponse.fileUrl;
          if (screens == Screens.fromDashboard) {
            isDataChanged = true.obs;
          }
          update();
        }
      }
    }
  }

  Future<void> updateUserDetails() async {
    if (firstNameTextController.text.isEmpty) {
      showSnackBar(context: Get.context!, message: 'First name can not be empty');
      return;
    }
    showLoaderDialog(context: Get.context!);
    final response = await _profileService.updateUserDataApi(
        profilePic: userModel.profilePic,
        martialStatus: userModel.maritalStatus,
        dateOfBirth: userModel.dateOfBirth,
        address: addressTextController.text,
        lastName: lastNmeTextController.text,
        firstName: firstNameTextController.text,
        gender: userModel.gender,
        email: emailTextController.text);

    if (response != null) {
      await Future.wait([
        GetStorage().write(firstName, response.firstName ?? ''),
        GetStorage().write(lastName, response.lastName ?? ''),
        GetStorage().write(profileUrl, response.profilePic ?? ''),
      ]);
      cancelDialog();
      Get.offAllNamed(RoutesConst.dashboardScreen);
    } else {
      cancelDialog();
    }
  }

  @override
  void onClose() {
    firstNameTextController.dispose();
    lastNmeTextController.dispose();
    emailTextController.dispose();
    dobTextController.dispose();
    addressTextController.dispose();
    phoneTextController.dispose();
    super.onClose();
  }
}
