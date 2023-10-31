import 'package:get/get.dart';
import 'package:where_hearts_meet/event_module/controller/add_event_controller.dart';


class AddEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEventController());
  }
}