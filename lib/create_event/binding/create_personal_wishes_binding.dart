import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_personal_wishes_controller.dart';

class CreatePersonalWishesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePersonalWishesController>(() => CreatePersonalWishesController());
  }
}
