import 'package:get/get.dart';

import '../controller/add_event_specials_controller.dart';

class AddEventSpecialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEventSpecialsController());
  }
}
