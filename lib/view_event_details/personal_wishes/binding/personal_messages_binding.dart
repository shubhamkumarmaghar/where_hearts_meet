import 'package:get/get.dart';

import '../controller/personal_messages_controller.dart';

class PersonalMessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalMessagesController>(() => PersonalMessagesController());
  }
}
