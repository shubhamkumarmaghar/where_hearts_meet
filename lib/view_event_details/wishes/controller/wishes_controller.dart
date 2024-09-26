import 'dart:math';

import 'package:heart_e_homies/utils/controller/base_controller.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';

class WishesController extends BaseController {
  List<WishesModel> wishesList = [];
  final _eventService = ViewEventService();
  late String eventId;
  late EventsCreated eventsCreated;
  late UserType userType;

  @override
  void onInit() {
    super.onInit();
    final repo = locator<CreatedEventRepo>();
    final event = repo.getCurrentEvent ?? EventResponseModel();
    eventId = event.eventid ?? '';
    eventsCreated = repo.getCurrentEventCreated ?? EventsCreated.byUser;
    userType = repo.getUserType ?? UserType.registered;
    if (eventId.isNotEmpty) {
      getEventWishes(eventId);
    }

  }

  Future<void> getEventWishes(String eventId) async {
    setBusy(true);
    var res = await _eventService.fetchWishesList(eventId: eventId);
    wishesList = res ?? [];
    setBusy(false);
    update();
  }
}
