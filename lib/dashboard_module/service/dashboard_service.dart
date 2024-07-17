import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class DashboardService {
  final ApiService _apiService = ApiService();

  Future<List<EventResponseModel>> getAllEventsCreatedByUserApi() async {
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
  Future<List<EventResponseModel>> getAllEventsCreatedForUserApi() async {
    String url = AppUrls.getAllEventsCreatedForUserUrl;
    var phoneNumber = GetStorage().read(userMobile) ??'';
    final response = await _apiService.getApiCall(
        url: url,
        queryParams: {
          "receiver_phone_number": phoneNumber
        }
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
