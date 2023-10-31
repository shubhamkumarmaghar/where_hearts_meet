import 'package:get/get.dart';

import '../controller/add_people_controller.dart';

class AddPeopleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPeopleController());
  }
}