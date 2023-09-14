import 'package:get/get.dart';

class BaseController extends GetxController {
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  void setBusy(bool value) {
    _isBusy = value;
    update();
  }
}
