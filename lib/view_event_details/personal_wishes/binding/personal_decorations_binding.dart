import 'package:get/get.dart';

import '../controller/personal_decorations_controller.dart';


class PersonalDecorationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDecorationsController>(() => PersonalDecorationsController());
  }
}
