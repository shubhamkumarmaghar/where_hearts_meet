import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_event_controller.dart';

class CreateEventBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CreateEventController());
  }

}