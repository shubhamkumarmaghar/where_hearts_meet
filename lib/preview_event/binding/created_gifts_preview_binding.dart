import 'package:get/get.dart';
import 'package:where_hearts_meet/preview_event/controller/created_gifts_preview_controller.dart';

class CreatedGiftsPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatedGiftsPreviewController>(() => CreatedGiftsPreviewController());
  }
}
