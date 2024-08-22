import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/personal_messages_model.dart';
import 'package:where_hearts_meet/utils/consts/screen_const.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import '../service/personal_wises_service.dart';

class PersonalMessagesController extends BaseController {
  PersonalMessagesModel? personalMessagesModel;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  final _personalWishesService = PersonalWishesService();

  @override
  void onInit() {
    super.onInit();
    var eventId = Get.arguments as String?;
    if (eventId != null && eventId.isNotEmpty) {
      getPersonalMessages(eventId: eventId);
    }
  }

  Future<void> getPersonalMessages({required String eventId}) async {
    loadingState.value = LoadingState.loading;
    final response = await _personalWishesService.getPersonalMessagesApi(eventId: eventId);
    if (response != null) {
      personalMessagesModel = response;
      loadingState.value = LoadingState.hasData;
    } else {
      personalMessagesModel = PersonalMessagesModel();
      loadingState.value = LoadingState.noData;
    }
    update();
  }
}
