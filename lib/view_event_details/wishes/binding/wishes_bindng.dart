import 'package:get/get.dart';

import '../controller/wishes_controller.dart';

class WishesBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<WishesController>(() => WishesController());
  }

}