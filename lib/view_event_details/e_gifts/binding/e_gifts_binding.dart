import 'package:get/get.dart';
import 'package:where_hearts_meet/view_event_details/e_gifts/controller/e_gifts_controller.dart';

class EGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EGiftsController>(() => EGiftsController());
  }
}
