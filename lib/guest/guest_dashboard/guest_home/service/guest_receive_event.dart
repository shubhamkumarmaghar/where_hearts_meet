import 'package:get_storage/get_storage.dart';

import '../../../../show_event_module/model/event_details_model.dart';
import '../../../../utils/consts/api_urls.dart';
import '../../../../utils/services/api_service.dart';

class GuestReceiveService {
  final ApiService _apiService = ApiService();


  Future<EventDetailsModel> getEventDetails({required String eventId,required String mobileNo}) async {
    String url = AppUrls.receiveEventUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams:{
        'eventid': eventId,
       'receiver_phone_number': mobileNo
      } ,

    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('event found')) {
      return EventDetailsModel.fromJson(data['data']);
    } else {
      return EventDetailsModel(eventid: '-1');
    }
  }
}