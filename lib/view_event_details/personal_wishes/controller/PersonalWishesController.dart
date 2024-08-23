import 'package:get/get.dart';

import '../../../create_event/model/personal_memories_model.dart';
import '../../../guest_dashboard/guest_home/controller/guest_home_controller.dart';
import '../../../utils/controller/base_controller.dart';
import '../model/personal_wishes_model.dart';
import '../service/personal_wises_service.dart';

class PersonalWishesController extends BaseController {
  PersonalWishesCoverModel? personalWishesCoverModel;
  List<PersonalMemoriesModel> memoriesList = [];
  final homeController = Get.find<GuestHomeController>();
  final PersonalWishesService _personalWishesService = PersonalWishesService();
  String eventId = '';

  @override
  void onInit() {
    var Id = Get.arguments as String;
    if (Id != '') eventId = Id;
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    await personalWishesCoverScreen(eventId: eventId);
  }

  Future<void> personalWishesCoverScreen({required String eventId}) async {
    setBusy(true);
    final response = await _personalWishesService.personalWishesApi(eventId: eventId);
    if (response != null) {
      personalWishesCoverModel = response;
    } else {
      personalWishesCoverModel = PersonalWishesCoverModel();
    }
    setBusy(false);
    update();
  }

  Future<void> personalWishesMemories({required String eventId}) async {
    setBusy(true);
    final response = await _personalWishesService.getPersonalMemoriesApi(eventId: eventId);
    if (response != null) {
      memoriesList = response;
    } else {
      memoriesList = [];
    }
    setBusy(false);
    update();
  }
}
