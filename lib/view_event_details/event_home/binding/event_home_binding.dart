import 'package:get/get.dart';

import '../controller/event_home_controller.dart';

class EventHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventHomeController>(() => EventHomeController());
  }
}
