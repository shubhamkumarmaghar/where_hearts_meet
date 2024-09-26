import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:heart_e_homies/view_event_details/service/view_event_service.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/gift_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/controller/base_controller.dart';
import '../../../utils/repository/created_event_repo.dart';

class EGiftsController extends BaseController {
  List<GiftModel>? giftsList;
  LoadingState loadingState = LoadingState.loading;
  final _eventService = ViewEventService();
  ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 10));
  late String eventId;
  late EventsCreated eventsCreated;
  late UserType userType;

  @override
  void onInit() {
    super.onInit();
    final repo = locator<CreatedEventRepo>();
    final eventDetails = repo.getCurrentEvent ?? EventResponseModel();
    eventId = eventDetails.eventid ?? '';
    eventsCreated = repo.getCurrentEventCreated ?? EventsCreated.byUser;
    userType = repo.getUserType ?? UserType.registered;
    if (eventId.isNotEmpty) {
      getEGifts(eventId: eventId);
    }
  }

  void onScratch({required double scratched, required int index}) async {
    if (scratched > 50.0) {
      giftsList![index].hasOpened = true;
      update();
      confettiController.play();
      await Future.delayed(const Duration(seconds: 5));
      confettiController.stop();
    }
  }

  Future<void> getEGifts({required String eventId}) async {
    loadingState = LoadingState.loading;
    update();
    final response = await _eventService.getEGiftsApi(eventId: eventId);
    if (response != null && response.isNotEmpty) {
      giftsList = response;
      loadingState = LoadingState.hasData;
    } else {
      giftsList = [];
      loadingState = LoadingState.noData;
    }
    update();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
