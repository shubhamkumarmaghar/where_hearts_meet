import 'package:get/get.dart';
import 'package:where_hearts_meet/guest_dashboard/personal_wishes/controller/personal_messages_controller.dart';

class PersonalMessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalMessagesController>(() => PersonalMessagesController());
  }
}
