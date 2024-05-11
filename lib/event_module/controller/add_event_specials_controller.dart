import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class AddEventSpecialsController extends BaseController {
  String eventName = '';

  @override
  void onInit() {
    super.onInit();
    eventName = Get.arguments as String;
  }
}
