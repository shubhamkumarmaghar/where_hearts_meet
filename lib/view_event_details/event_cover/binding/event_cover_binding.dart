import 'package:get/get.dart';

import '../controller/event_cover_controller.dart';

class EventCoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventCoverController>(() => EventCoverController());
  }
}
