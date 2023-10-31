import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/services/firebase_firestore_controller.dart';

import '../../utils/consts/color_const.dart';
import '../model/people_model.dart';

class PeopleListController extends BaseController {
  final firestoreController = Get.find<FirebaseFireStoreController>();
  List<PeopleModel> peopleList = [];

  @override
  void onInit() {
    getPeopleList();
    super.onInit();
  }

  Future<void> getPeopleList() async {
    setBusy(true);
    peopleList = await firestoreController.getPeopleList();
    setBusy(false);
  }

}
