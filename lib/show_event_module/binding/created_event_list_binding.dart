import 'package:get/get.dart';
import '../controller/created_event_list_controller.dart';

class CreatedEventListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatedEventListController());
  }
}
