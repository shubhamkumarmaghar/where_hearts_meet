import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/gift_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/view_event_details/e_gifts/service/e_gifts_service.dart';

import '../../../utils/consts/screen_const.dart';

class EGiftsController extends BaseController {
  List<GiftModel>? giftsList;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  final _giftsService = EGiftsService();

  @override
  void onInit() {
    super.onInit();
    var eventId = Get.arguments as String?;
    if (eventId != null && eventId.isNotEmpty) {
      getEGifts(eventId: eventId);
    }
  }

  Future<void> getEGifts({required String eventId}) async {
    loadingState.value = LoadingState.loading;
    final response = await _giftsService.getEGiftsApi(eventId: eventId);
    if (response != null && response.isNotEmpty) {
      giftsList = response;
      loadingState.value = LoadingState.hasData;
    } else {
      giftsList = [];
      loadingState.value = LoadingState.noData;
    }
    update();
  }
}
