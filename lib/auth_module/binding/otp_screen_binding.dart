import 'package:get/get.dart';
import 'package:heart_e_homies/auth_module/controller/otp_screen_controller.dart';

class OtpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpScreenController());
  }
}
