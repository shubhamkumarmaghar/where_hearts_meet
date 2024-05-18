import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../model/create_event_model.dart';

class EventApiService {
  ApiService _apiService = ApiService();

  Future<CreateEventResponseModel> createEvent(
      {required String eventName,
        required String hostName,
        required eventType,
        required eventHostDay,
        required eventSubtext,
        required eventDescription,
      }) async {
    String url = AppUrls.createEventUrl;
    final response = await _apiService.postApiCall(
      url: url,
      data: {'event_name': eventName,
        'host_name': hostName,
        'event_type': eventType,
        'event_host_day':eventHostDay,
        'event_subtext':eventSubtext,
        'event_description':eventDescription,
      },
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('Event created successfully')) {
      return CreateEventResponseModel.fromJson(data);
    } else {
      return CreateEventResponseModel(message: 'failure');
    }
  }

}