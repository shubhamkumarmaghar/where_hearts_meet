
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/show_event_module/model/events_list_model.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class ShowEventApiService {
  final ApiService _apiService = ApiService();

  Future<List<EventsListModel>> getAllEvents() async {
    String url = AppUrls.allEventsUrl;
    final String userName = 'deepak@1234';//await GetStorage().read(username);

    final response = await _apiService.getApiCall(
      url: url,
      queryParams:{'username': userName} ,

    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('events found')) {
      Iterable iterable = data['data'];
      final list = iterable.map((event) => EventsListModel.fromJson(event)).toList();
      return list;
    } else {
      return [];
    }
  }
}