import '../../create_event/model/event_response_model.dart';
import '../consts/screen_const.dart';

class CreatedEventRepo {
  static EventResponseModel? _eventResponseModel;
  static EventsCreated? _eventsCreated;
  static UserType? _userType;
  static AppActions _actions = AppActions.view;

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

  void setAppActions(AppActions appActions) {
    _actions = appActions;
  }

  AppActions get actions => _actions;

  void clearRepo() {
    _eventResponseModel = null;
    _eventsCreated = null;
    _userType = null;
    _actions = AppActions.view;
  }
}
