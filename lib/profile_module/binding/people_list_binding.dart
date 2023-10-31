import 'package:get/get.dart';

import '../controller/people_list_controller.dart';

class PeopleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PeopleListController());
  }
}