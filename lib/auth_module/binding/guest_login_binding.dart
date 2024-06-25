import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:where_hearts_meet/auth_module/controller/guest_login_controller.dart';

class GuestLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestLoginController());
  }
}