import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

import '../../create_event/model/gift_model.dart';

class CreatedGiftsPreviewController extends BaseController{
 late List<GiftModel> giftsList;

 @override
  void onInit() {
   super.onInit();
   final res = Get.arguments as List<GiftModel>?;
   giftsList = res ?? [];
 }
}