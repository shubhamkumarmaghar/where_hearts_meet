import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/controller/base_controller.dart';
import '../../guest_home/controller/guest_home_controller.dart';
import '../model/personal_wishes_model.dart';
import '../service/personal_wises_service.dart';

class PersonalWishesController extends BaseController {
  PersonalWishesCoverModel? personalWishesCoverModel;
  final homeController = Get.find<GuestHomeController>();
  PersonalWishesService _personalWishesService = PersonalWishesService();
  String eventId = '';
  @override
  void onInit() {
    var Id = Get.arguments as String;
    if(Id != '' ) eventId = Id;
    getData();
    super.onInit();
  }
  Future<void> getData() async {
    await eventsListCreatedByUser(eventId: eventId);
  }

  Future<void> eventsListCreatedByUser({required String eventId}) async {
    setBusy(true);
    final response = await _personalWishesService.personalWishesApi(eventId:eventId );
    if (response != null ) {
      personalWishesCoverModel = response;
    } else {
      personalWishesCoverModel=PersonalWishesCoverModel();
    }
    setBusy(false);
    update();
  }


}