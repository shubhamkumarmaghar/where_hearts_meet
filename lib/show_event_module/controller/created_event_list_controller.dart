import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/utils/dialogs/pop_up_dialogs.dart';
import '../../create_event_module/model/add_event_model.dart';
import '../../utils/services/firebase_auth_controller.dart';
import '../../utils/services/firebase_firestore_controller.dart';

class CreatedEventListController extends BaseController {
  final fireStoreController = Get.find<FirebaseFireStoreController>();
  final firebaseAuthController = Get.find<FirebaseAuthController>();
  List<AddEventModel> allEventList = [];
  List<AddEventModel> currentUserEventList = [];

  @override
  void onInit() {
    getCreatedEventList(initial: true);
    super.onInit();
  }

  Future<void> getCreatedEventList({required bool initial}) async {
    if (initial) {
      setBusy(true);
    }
    final email = firebaseAuthController.getCurrentUser()?.email;
    allEventList = await fireStoreController.getEventList();
    for (var data in allEventList) {
      if (data.fromEmail == email) {
        currentUserEventList.add(data);
      }
    }
    if (initial) {
      setBusy(false);
    }
    update();
  }

  Future<void> deleteCreatedEvent({required String eventId}) async {
    showLoaderDialog(context: Get.context!);
    await fireStoreController.deleteCreatedEvent(eventId: eventId);
    currentUserEventList.clear();
    await getCreatedEventList(initial: false);
    cancelLoaderDialog();

    update();
  }
}
