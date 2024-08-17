import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/profile_module/service/profile_service.dart';
import 'package:where_hearts_meet/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/consts/app_screen_size.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/dialogs/select_data_dialog.dart';
import 'package:where_hearts_meet/utils/repository/user_data.dart';
import 'package:where_hearts_meet/utils/util_functions/decoration_functions.dart';
import '../../utils/util_functions/app_pickers.dart';
import '../model/user_model.dart';

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
  DateTime _initialDateTime = DateTime.now().subtract(Duration(days: 5000));

  @override
  void onInit() {
    super.onInit();
    getUserData();
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
      parseDOB();
      loadingState = LoadingState.hasData;

      update();
    } else {
      loadingState = LoadingState.noData;
      update();
    }
  }

  Future<void> selectGender() async {
    final res = await selectDataDialog(
        context: Get.context!, title: 'Select Gender', dataList: gendersList, height: screenHeight * 0.3);
    if (res != null) {
      isDataChanged = true.obs;
      userModel.gender = res.title;
      update();
    }
  }

  Future<void> updateUserDetails() async {
    showLoaderDialog(context: Get.context!);
    final response = await _profileService.updateUserDataApi(
        profilePic: null,
        //userModel.profilePic,
        martialStatus: userModel.maritalStatus,
        dateOfBirth: userModel.dateOfBirth,
        address: addressTextController.text,
        lastName: lastNmeTextController.text,
        firstName: firstNameTextController.text,
        gender: userModel.gender,
        email: emailTextController.text);
    cancelDialog();
    if (response != null) {
      Get.offAllNamed(RoutesConst.dashboardScreen);
    }
  }

  void onSelectDOB() async {
    final date = await dateOfBirthPicker(context: Get.context!, initialDate: _initialDateTime);

    if (date != null) {
      log('${date}');
      isDataChanged.value = true;
    }
  }
  void parseDOB() {
    if (userModel.dateOfBirth != null && userModel.dateOfBirth!.isNotEmpty) {
      try {
        _initialDateTime = DateTime.parse(userModel.dateOfBirth!);
      } catch (e) {
        log(e.toString());
      }
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
