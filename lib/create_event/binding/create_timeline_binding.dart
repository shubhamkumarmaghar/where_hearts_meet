import 'package:get/get.dart';

import '../controller/create_timeline_controller.dart';

class CreateTimelineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CreateTimelineController>(() => CreateTimelineController());
  }

}