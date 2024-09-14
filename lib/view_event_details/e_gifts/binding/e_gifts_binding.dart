import 'package:get/get.dart';

import '../controller/e_gifts_controller.dart';

class EGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EGiftsController>(() => EGiftsController());
  }
}
