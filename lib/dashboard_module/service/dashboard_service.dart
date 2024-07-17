import 'package:where_hearts_meet/create_event/model/event_response_model.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class DashboardService {
  final ApiService _apiService = ApiService();

  Future<List<EventResponseModel>> getAllEvents() async {
    String url = AppUrls.allEventsUrl;
    final response = await _apiService.getApiCall(
      url: url,
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('events found')) {
      Iterable iterable = data['data'];
      return iterable.map((e) => EventResponseModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
