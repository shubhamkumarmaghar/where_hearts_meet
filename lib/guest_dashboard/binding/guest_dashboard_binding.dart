import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../controller/guest_dashboard_controller.dart';
import '../guest_home/controller/guest_home_controller.dart';

class GuestDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestDashboardController());
  }
}