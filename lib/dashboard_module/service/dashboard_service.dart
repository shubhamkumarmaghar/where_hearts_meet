import 'package:get_storage/get_storage.dart';

import '../../create_event/model/event_response_model.dart';
import '../../utils/consts/api_urls.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/services/api_service.dart';

class DashboardService {
  final ApiService _apiService = ApiService();

  Future<List<EventResponseModel>?> getAllEventsCreatedByUserApi() async {
    String url = AppUrls.eventsCreatedByUserUrl;
    final response = await _apiService.getApiCall(
      url: url,
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('events found') && data['data'] != null) {
      Iterable iterable = data['data'];
      return iterable.map((e) => EventResponseModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<EventResponseModel>?> getAllEventsCreatedForUserApi() async {
    String url = AppUrls.eventsCreatedForUserUrl;
    var phoneNumber = GetStorage().read(userMobile) ?? '';
    final response = await _apiService.getApiCall(url: url, queryParams: {"receiver_phone_number": phoneNumber});
    final data = response;

    if (data['message'].toString().toLowerCase().contains('events found') && data['data'] != null) {
      Iterable iterable = data['data'];
      return iterable.map((e) => EventResponseModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<String?> deleteEventApi({required String eventId, bool? deleteForMe, bool? deleteForEveryone}) async {
    String url = AppUrls.createEventUrl;
    Map<String, dynamic> params = {
      "eventid": eventId,
    };
    if (deleteForMe != null) {
      params.addAll({'delete_for_host': deleteForMe});
    }
    if (deleteForEveryone != null) {
      params.addAll({'delete_for_receiver': deleteForEveryone});
    }

    final response = await _apiService.deleteApiCall(url: url, queryParams: params);

    if (response['message'].toLowerCase().contains('event deleted')) {
      return response['message'];
    } else {
      return null;
    }
  }
}
