import 'package:get/get.dart';
import 'package:where_hearts_meet/auth_module/controller/profile_setup_controller.dart';

class ProfileSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileSetupController());
  }
}