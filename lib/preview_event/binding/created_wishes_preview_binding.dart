import 'package:get/get.dart';

import '../controller/created_wishes_preview_controller.dart';

class CreatedWishesPreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CreatedWishesPreviewController());
  }

}