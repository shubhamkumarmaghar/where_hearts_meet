import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/event_gender_controller.dart';
import '../controller/event_list_controller.dart';

class EventGenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventGenderController());
  }
}