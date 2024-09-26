import 'package:get/get.dart';

import '../../../create_event/model/event_response_model.dart';
import '../../../create_event/model/personal_decorations_model.dart';
import '../../../utils/consts/screen_const.dart';
import '../../../utils/consts/service_const.dart';
import '../../../utils/controller/base_controller.dart';
import '../../../utils/repository/created_event_repo.dart';
import '../../service/view_event_service.dart';

class PersonalDecorationsController extends BaseController {
  PersonalDecorationsModel? personalDecorationsModel;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  final _eventService = ViewEventService();
  RxBool imagesSelected = true.obs;
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
      getPersonalDecorations(eventId: eventId);
    }
  }

  Future<void> getPersonalDecorations({required String eventId}) async {
    loadingState.value = LoadingState.loading;
    final response = await _eventService.getPersonalDecorationsApi(eventId: eventId);
    if (response != null) {
      personalDecorationsModel = response;
      loadingState.value = LoadingState.hasData;
    } else {
      personalDecorationsModel = PersonalDecorationsModel();
      loadingState.value = LoadingState.noData;
    }
    update();
  }

  void toggleMediaChange() {
    imagesSelected.value = !imagesSelected.value;
  }

  @override
  void onClose() {
    imagesSelected.close();
    loadingState.close();
    super.onClose();
  }
}
