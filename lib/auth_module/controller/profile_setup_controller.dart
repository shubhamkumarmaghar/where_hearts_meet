import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/services/firebase_login.dart';
import '../../utils/routes/routes_const.dart';
import '../profile_setup_const.dart';
import '../screens/add_location_page.dart';
import '../screens/add_name_page.dart';
import '../screens/add_profile_picture_page.dart';

class ProfileSetupController extends BaseController {
  int pageIndex = 1;

  final nameTextController = TextEditingController();
  final birthDateTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  RxnString errorNameText = RxnString(null);
  RxnString errorMobileText = RxnString(null);
  Rx<String> dateOfBirth = 'Date of birth'.obs;

  void onNameChanged(String name) {
    if (name.length > 2 && GetUtils.isAlphabetOnly(name)) {
      errorNameText.value = null;
    } else {
      errorNameText.value = 'Enter valid name';
    }
  }

  void onMobileChanged(String mobile) {
    if (GetUtils.isAlphabetOnly(mobile)) {
      errorNameText.value = null;
    } else {
      errorNameText.value = 'Enter valid mobile number';
    }
  }

  void onChangePageIndex(int index) {
    pageIndex = index;
    update();
  }

  void onNext() async {
    if (pageIndex == CompleteProfilePageIndex.addProfilePicturePage) {
      showLoaderDialog(context: Get.context!);
      final firebaseAuthController = Get.find<FirebaseAuthController>();
      final user =  firebaseAuthController.getCurrentUser();
      if (user != null) {
        await user.updateDisplayName(nameTextController.text);
      }
      cancelLoaderDialog();
      Get.toNamed(RoutesConst.dashboardScreen);
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

  @override
  void dispose() {
    nameTextController.dispose();
    birthDateTextController.dispose();
    mobileTextController.dispose();
    super.dispose();
  }
}
