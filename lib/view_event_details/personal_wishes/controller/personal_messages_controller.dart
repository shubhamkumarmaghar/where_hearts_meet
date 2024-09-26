import 'package:get/get.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/personal_messages_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/controller/base_controller.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';

class PersonalMessagesController extends BaseController {
  PersonalMessagesModel? personalMessagesModel;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  final _eventService = ViewEventService();
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
      getPersonalMessages(eventId: eventId);
    }
  }

  Future<void> getPersonalMessages({required String eventId}) async {
    loadingState.value = LoadingState.loading;
    final response = await _eventService.getPersonalMessagesApi(eventId: eventId);
    if (response != null) {
      personalMessagesModel = response;
      loadingState.value = LoadingState.hasData;
    } else {
      personalMessagesModel = PersonalMessagesModel();
      loadingState.value = LoadingState.noData;
    }
    update();
  }
}
