import 'package:get/get.dart';
import '../controller/PersonalWishesController.dart';

class PersonalWishesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalWishesController());
  }
}