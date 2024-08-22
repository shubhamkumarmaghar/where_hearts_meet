import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_wishes_controller.dart';

class CreateWishesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWishesController());
  }

}