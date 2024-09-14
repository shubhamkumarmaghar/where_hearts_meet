import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

import '../../create_event/model/gift_model.dart';
import '../../utils/controller/base_controller.dart';

class CreatedGiftsPreviewController extends BaseController{
 late List<GiftModel> giftsList;
 ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 10));

 @override
  void onInit() {
   super.onInit();
   final res = Get.arguments as List<GiftModel>?;
   giftsList = res ?? [];
 }

 void onScratch({required double scratched, required int index}) async {
  if (scratched > 50.0) {
   giftsList[index].hasOpened = true;
   update();
   confettiController.play();
   await Future.delayed(const Duration(seconds: 5));
   confettiController.stop();
  }
 }

 @override
 void dispose() {
  confettiController.dispose();
  super.dispose();
 }
}