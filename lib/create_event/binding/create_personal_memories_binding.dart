import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/controller/create_personal_memories_controller.dart';

class CreatePersonalMemoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePersonalMemoriesController>(() => CreatePersonalMemoriesController());
  }
}
