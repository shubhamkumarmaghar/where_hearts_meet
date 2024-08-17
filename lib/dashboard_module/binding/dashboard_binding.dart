import 'package:get/get.dart';
import 'package:where_hearts_meet/dashboard_module/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
