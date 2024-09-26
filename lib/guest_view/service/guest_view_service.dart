import 'package:heart_e_homies/create_event/model/event_response_model.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class GuestViewService {
  final _apiService = ApiService();

  Future<EventResponseModel?> getEventDetails({required String eventId, required String mobileNo}) async {
    final response = await _apiService.getApiCall(
      url: AppUrls.receiveEventUrl,
      queryParams: {
        'eventid': eventId,
        'receiver_phone_number': mobileNo,
      },
    );

    if (response['message'].toString().toLowerCase().contains('event found') && response['data'] != null) {
      return EventResponseModel.fromJson(response['data']);
    } else {
      return null;
    }
  }
}
