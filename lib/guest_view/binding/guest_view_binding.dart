import 'package:get/get.dart';
import 'package:heart_e_homies/guest_view/controller/guest_view_controller.dart';

class GuestViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestViewController>(() => GuestViewController());
  }
}
