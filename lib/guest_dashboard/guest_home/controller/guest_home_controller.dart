import 'package:confetti/confetti.dart';

import '../../../utils/controller/base_controller.dart';

class GuestHomeController extends BaseController {
  late ConfettiController homeConfettiController;

  @override
  void onInit() {
    super.onInit();
    homeConfettiController = ConfettiController(duration: const Duration(minutes: 1));
    homeConfettiController.play();
  }

  @override
  void onClose() {
    homeConfettiController.dispose();
    super.onClose();
  }
}