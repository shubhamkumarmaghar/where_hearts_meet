import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_personal_cover_controller.dart';

class CreatePersonalCoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePersonalCoverController>(() => CreatePersonalCoverController());
  }
}
