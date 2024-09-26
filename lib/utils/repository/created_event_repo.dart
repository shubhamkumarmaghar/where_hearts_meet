
import '../../create_event/model/event_response_model.dart';
import '../consts/screen_const.dart';

class CreatedEventRepo {
  static EventResponseModel? _eventResponseModel;
  static EventsCreated? _eventsCreated;
  static UserType? _userType;

  void setEvent(EventResponseModel? eventResponseModel) {
    _eventResponseModel = eventResponseModel;
  }

  EventResponseModel? get getCurrentEvent => _eventResponseModel;

  void setEventCreated(EventsCreated? eventsCreated) {
    _eventsCreated = eventsCreated;
  }

  EventsCreated? get getCurrentEventCreated => _eventsCreated;

  void setUserType(UserType? userType) {
    _userType = userType;
  }

  UserType? get getUserType => _userType;
}
