import 'package:get/get.dart';
import 'package:where_hearts_meet/preview_event/controller/created_memories_preview_controller.dart';

class CreatedMemoriesPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatedMemoriesPreviewController>(() => CreatedMemoriesPreviewController());
  }
}
