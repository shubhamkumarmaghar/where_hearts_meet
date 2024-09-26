import 'package:get/get.dart';
import '../controller/personal_memories_controller.dart';

class PersonalMemoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalMemoriesController());
  }
}