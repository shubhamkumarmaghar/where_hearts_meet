import 'package:get/get.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/personal_memories_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/controller/base_controller.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';
import '../model/personal_wishes_model.dart';

class PersonalMemoriesController extends BaseController {
  PersonalWishesCoverModel? personalWishesCoverModel;
  List<PersonalMemoriesModel> memoriesList = [];
  final _eventService = ViewEventService();
  late String eventId;
  late EventsCreated eventsCreated;
  late UserType userType;
  late EventResponseModel eventDetails;

  @override
  void onInit() {
    super.onInit();
    final repo = locator<CreatedEventRepo>();
    eventDetails = repo.getCurrentEvent ?? EventResponseModel();
    eventId = eventDetails.eventid ?? '';
    eventsCreated = repo.getCurrentEventCreated ?? EventsCreated.byUser;
    userType = repo.getUserType ?? UserType.registered;
    if (eventId.isNotEmpty) {
      personalWishesCoverScreen(eventId: eventId);
      personalWishesMemories(eventId: eventId);
    }
  }

  Future<void> personalWishesCoverScreen({required String eventId}) async {
    setBusy(true);
    final response = await _eventService.personalWishesApi(eventId: eventId);
    if (response != null) {
      personalWishesCoverModel = response;
    } else {
      personalWishesCoverModel = PersonalWishesCoverModel();
    }
    setBusy(false);
    update();
  }

  Future<void> personalWishesMemories({required String eventId}) async {
    setBusy(true);
    final response = await _eventService.getPersonalMemoriesApi(eventId: eventId);
    if (response != null) {
      memoriesList = response;
    } else {
      memoriesList = [];
    }
    setBusy(false);
    update();
  }
}
