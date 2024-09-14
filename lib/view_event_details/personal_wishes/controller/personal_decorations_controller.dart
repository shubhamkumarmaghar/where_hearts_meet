import 'package:get/get.dart';

import '../../../create_event/model/personal_decorations_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/controller/base_controller.dart';
import '../service/personal_wises_service.dart';

class PersonalDecorationsController extends BaseController {
  PersonalDecorationsModel? personalDecorationsModel;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  final _personalWishesService = PersonalWishesService();
  RxBool imagesSelected = true.obs;

  @override
  void onInit() {
    super.onInit();
    var eventId = Get.arguments as String?;
    if (eventId != null && eventId.isNotEmpty) {
      getPersonalDecorations(eventId: eventId);
    }
  }

  Future<void> getPersonalDecorations({required String eventId}) async {
    loadingState.value = LoadingState.loading;
    final response = await _personalWishesService.getPersonalDecorationsApi(eventId: eventId);
    if (response != null) {
      personalDecorationsModel = response;
      loadingState.value = LoadingState.hasData;
    } else {
      personalDecorationsModel = PersonalDecorationsModel();
      loadingState.value = LoadingState.noData;
    }
    update();
  }

  void toggleMediaChange() {
    imagesSelected.value = !imagesSelected.value;
  }

  @override
  void onClose() {
    imagesSelected.close();
    loadingState.close();
    super.onClose();
  }
}
