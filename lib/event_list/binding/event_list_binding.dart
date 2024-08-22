import 'package:get/get.dart';
import 'package:where_hearts_meet/event_list/controller/event_list_controller.dart';


class EventListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventListController>(() => EventListController());
  }
}
