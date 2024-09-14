import 'package:get/get.dart';

import '../controller/created_memories_preview_controller.dart';

class CreatedMemoriesPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatedMemoriesPreviewController>(() => CreatedMemoriesPreviewController());
  }
}
