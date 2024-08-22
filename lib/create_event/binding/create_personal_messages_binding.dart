import 'package:get/get.dart';

import '../controller/create_personal_messages_controller.dart';

class CreatePersonalMessagesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CreatePersonalMessagesController>(() => CreatePersonalMessagesController());
  }

}