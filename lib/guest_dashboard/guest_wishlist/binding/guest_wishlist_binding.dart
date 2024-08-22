import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../guest_home/controller/guest_home_controller.dart';
import '../controller/WishesController.dart';

class GuestWishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestWishesController());
  }
}