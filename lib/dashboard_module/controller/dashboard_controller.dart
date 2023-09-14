import 'package:confetti/confetti.dart';
import 'package:where_hearts_meet/utils/controller/base_controller.dart';

class DashboardController extends BaseController{
  late ConfettiController eventConfettiController;

  @override
  void onInit() {
    super.onInit();
    eventConfettiController = ConfettiController(duration: const Duration(hours: 1));
    eventConfettiController.play();
  }
  @override
  void onClose() {
    eventConfettiController.dispose();
    super.onClose();
  }
}