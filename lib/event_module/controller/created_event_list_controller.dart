import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import '../../utils/services/firebase_auth_controller.dart';
import '../../utils/services/firebase_firestore_controller.dart';
import '../model/add_event_model.dart';

class CreatedEventListController extends BaseController {
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  List<AddEventModel> allEventList = [];
  List<AddEventModel> currentUserEventList = [];

  @override
  void onInit() {
    getCreatedEventList();
    super.onInit();
  }

  Future<void> getCreatedEventList() async {
    setBusy(true);
    final email = firebaseAuthController.getCurrentUser()?.email;
    allEventList = await fireStoreController.getEventList();
    for (var data in allEventList) {
      if (data.fromEmail == email) {
        currentUserEventList.add(data);
      }
    }
    setBusy(false);
    update();
  }
  Future<void> deleteCreatedEvent() async {
    setBusy(true);
    final email = firebaseAuthController.getCurrentUser()?.email;
    allEventList = await fireStoreController.getEventList();
    for (var data in allEventList) {
      if (data.fromEmail == email) {
        currentUserEventList.add(data);
      }
    }
    setBusy(false);
    update();
  }
}
