import 'package:get/get.dart';

import '../controller/create_wishes_controller.dart';

class CreateWishesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWishesController());
  }

}