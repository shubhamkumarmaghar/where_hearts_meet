import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';

import '../../utils/consts/color_const.dart';
import '../model/people_model.dart';

class PeopleListController extends BaseController {
  final firestoreController = Get.find<FirebaseFireStoreController>();
  List<PeopleModel> peopleList = [];

  @override
  void onInit() {
    getPeopleList(initial: true);
    super.onInit();
  }

  Future<void> getPeopleList({required bool initial}) async {
    if (initial) {
      setBusy(true);
    }
    peopleList = await firestoreController.getPeopleList();
    if (initial) {
      setBusy(false);
    }
  }

  Future<void> deletePeople({required String email}) async {
    showLoaderDialog(context: Get.context!);
    await firestoreController.deletePeople(email: email);
   getPeopleList(initial: false);
    cancelLoaderDialog();
    update();
  }
}
