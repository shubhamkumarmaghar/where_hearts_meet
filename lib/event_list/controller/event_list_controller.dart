import 'package:get/get.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';

import '../../utils/consts/screen_const.dart';
import '../../utils/controller/base_controller.dart';
import '../../utils/dialogs/pop_up_dialogs.dart';
import '../service/event_list_service.dart';

class EventListController extends BaseController {
  final _eventListService = EventListService();
  List<EventResponseModel> eventsList = [];
  late EventsCreated eventsCreated;
  late String pageTitle;
  late bool forSelf;

  @override
  void onInit() {
    super.onInit();
    eventsCreated = Get.arguments as EventsCreated;
    if (eventsCreated == EventsCreated.forUser) {
      pageTitle = 'Received Events';
      eventsListCreatedForUser();
      forSelf = true;
    } else {
      pageTitle = 'Created Events';
      eventsListCreatedByUser();
      forSelf = false;
    }
  }

  Future<void> eventsListCreatedByUser() async {
    setBusy(true);
    final response = await _eventListService.eventsListCreatedByUserApi();
    if (response.isNotEmpty) {
      eventsList = response;
    }
    setBusy(false);
    update();
  }

  Future<void> eventsListCreatedForUser() async {
    setBusy(true);
    final response = await _eventListService.eventsListCreatedForUserApi();
    if (response.isNotEmpty) {
      eventsList = response;
    }
    setBusy(false);
    update();
  }

  void deleteEvent({required String eventId}) async {
    showLoaderDialog(context: Get.context!);
    final res = await _eventListService.deleteEventApi(eventId: eventId);
    cancelDialog();
    if (res != null) {
      eventsList.removeWhere((element) => element.eventid == eventId);
    }
    update();
  }
}
