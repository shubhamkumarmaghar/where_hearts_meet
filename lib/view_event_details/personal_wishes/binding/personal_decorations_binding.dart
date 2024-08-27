import 'package:get/get.dart';
import 'package:where_hearts_meet/view_event_details/personal_wishes/controller/personal_decorations_controller.dart';

class PersonalDecorationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDecorationsController>(() => PersonalDecorationsController());
  }
}
