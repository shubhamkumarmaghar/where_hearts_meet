import 'package:get/get.dart';

import '../controller/created_gifts_preview_controller.dart';

class CreatedGiftsPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatedGiftsPreviewController>(() => CreatedGiftsPreviewController());
  }
}
