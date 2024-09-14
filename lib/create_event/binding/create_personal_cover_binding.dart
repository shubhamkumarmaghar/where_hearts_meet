import 'package:get/get.dart';

import '../controller/create_personal_cover_controller.dart';

class CreatePersonalCoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePersonalCoverController>(() => CreatePersonalCoverController());
  }
}
