import 'package:get/get.dart';

import '../controller/create_personal_decorations_controller.dart';

class CreatePersonalDecorationsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CreatePersonalDecorationsController>(() => CreatePersonalDecorationsController());
  }

}