import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/model/user_info_model.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';
import 'package:where_hearts_meet/utils/services/firebase_storage_controller.dart';
import '../../dashboard_module/controller/dashboard_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../model/people_model.dart';

class EditProfileController extends BaseController {
  final nameTextController = TextEditingController();
  final emailController = TextEditingController();
  RxnString errorNameText = RxnString(null);
  final firestoreController = Get.find<FirebaseFireStoreController>();
  UserInfoModel userInfoModel = UserInfoModel();
  FirebaseFireStoreController fireStoreController = Get.find<FirebaseFireStoreController>();
  FirebaseStorageController firebaseStorageController = Get.find<FirebaseStorageController>();
  List<PeopleModel> userPeopleList = [];

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
    if (initial) {
      setBusy(true);
    }

    final data = await fireStoreController.getCurrentUserFromFireStore();
    if (data != null) {
      userInfoModel = data;
      nameTextController.text = userInfoModel.name ?? '';
      emailController.text = userInfoModel.email ?? '';
      if (userInfoModel.peopleList != null && userInfoModel.peopleList!.isNotEmpty) {
        userPeopleList =
            await fireStoreController.getPeopleListFromModel(peopleListFromModel: userInfoModel.peopleList ?? []);
      }
    }
    if (initial) {
      setBusy(false);
    }
    update();
  }

  void updateDateOfBirth({required String dateOfBirth}) {
    userInfoModel.dateOfBirth = dateOfBirth;
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
      final url = await firebaseStorageController.uploadPic(file: imageFile);
      userInfoModel.imageUrl = url;
      cancelDialog();
      update();
    }
  }

  Future<void> updateUserData() async {
    if (errorNameText.value != null) {
      showSnackBar(context: Get.context!,message: 'Please enter name');
      return;
    } else if (userInfoModel.dateOfBirth == null) {
      showSnackBar(context: Get.context!,message: 'Please select date of birth');
      return;
    }
    userInfoModel.name = nameTextController.text;

    showLoaderDialog(context: Get.context!);
    await fireStoreController.updateUserData(userInfoModel: userInfoModel);

    cancelDialog();
    Get.offAllNamed(RoutesConst.dashboardScreen);
  }

  @override
  void onClose() {
    nameTextController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
