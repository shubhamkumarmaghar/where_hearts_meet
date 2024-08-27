import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/gift_model.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';
import 'package:where_hearts_meet/view_event_details/e_gifts/service/e_gifts_service.dart';

import '../../../utils/consts/screen_const.dart';

class EGiftsController extends BaseController {
  List<GiftModel>? giftsList;
  LoadingState loadingState = LoadingState.loading;
  final _giftsService = EGiftsService();
  ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 10));

  @override
  void onInit() {
    super.onInit();
    var eventId = Get.arguments as String?;
    if (eventId != null && eventId.isNotEmpty) {
      getEGifts(eventId: eventId);
    }
  }

  void onScratch({required double scratched, required int index}) async {
    if (scratched > 70.0) {
      giftsList![index].hasOpened = true;
      update();
      confettiController.play();
      await Future.delayed(const Duration(seconds: 5));
      confettiController.stop();
    }
  }

  Future<void> getEGifts({required String eventId}) async {
    loadingState = LoadingState.loading;
    update();
    final response = await _giftsService.getEGiftsApi(eventId: eventId);
    if (response != null && response.isNotEmpty) {
      giftsList = response;
      loadingState = LoadingState.hasData;
    } else {
      giftsList = [];
      loadingState = LoadingState.noData;
    }
    update();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
