import 'package:get/get.dart';
import 'package:where_hearts_meet/edit_profile_module/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}