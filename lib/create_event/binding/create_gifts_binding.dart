import 'package:get/get.dart';

import '../controller/create_gifts_controller.dart';

class CreateGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGiftsController>(() => CreateGiftsController());
  }
}
