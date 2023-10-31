import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../profile_module/model/people_model.dart';
import '../../utils/services/firebase_firestore_controller.dart';

class DashboardController extends BaseController{
  late ConfettiController eventConfettiController;
  final firestoreController = Get.find<FirebaseFireStoreController>();
  List<PeopleModel> peopleList = [];
  RxBool showPeopleView = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getPeopleList();
    eventConfettiController = ConfettiController(duration: const Duration(hours: 1));
    eventConfettiController.play();
  }
  Future<void> getPeopleList() async {
    showPeopleView.value = false;
    peopleList = await firestoreController.getPeopleList();
    showPeopleView.value = true;
  }
  @override
  void onClose() {
    eventConfettiController.dispose();
    super.onClose();
  }
}