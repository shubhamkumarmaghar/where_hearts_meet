import 'package:where_hearts_meet/create_event/model/event_response_model.dart';

class CreatedEventRepo {
  static EventResponseModel? _eventResponseModel;

  void setEvent(EventResponseModel eventResponseModel) {
    _eventResponseModel = eventResponseModel;
  }

  EventResponseModel? get getCurrentEvent => _eventResponseModel;
}
