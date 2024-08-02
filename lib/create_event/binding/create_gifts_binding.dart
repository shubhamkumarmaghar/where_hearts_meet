import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_gifts_controller.dart';

class CreateGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateGiftsController>(() => CreateGiftsController());
  }
}
