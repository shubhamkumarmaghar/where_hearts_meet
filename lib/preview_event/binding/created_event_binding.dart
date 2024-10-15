import 'package:get/get.dart';

import '../controller/created_event_preview_controller.dart';

class CreatedEventPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatedEventPreviewController>(() => CreatedEventPreviewController());
  }
}
