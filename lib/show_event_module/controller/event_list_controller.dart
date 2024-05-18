
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/routes/routes_const.dart';
import 'package:where_hearts_meet/utils/services/firebase_auth_controller.dart';

import '../../create_event_module/model/add_event_model.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../../utils/services/firebase_storage_controller.dart';

class EventListController extends BaseController {
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  List<AddEventModel> allEventList=[];
  List<AddEventModel> currentUserEventList=[];

  @override
  void onInit() {
    getEventList();
    super.onInit();
  }


  Future<void> getEventList() async {
   setBusy(true);
   final email=firebaseAuthController.getCurrentUser()?.email;
   allEventList=await fireStoreController.getEventList();
   for (var data in allEventList){
     if(data.toEmail == email){
       currentUserEventList.add(data);
     }
   }
   setBusy(false);
   update();
  }

}
