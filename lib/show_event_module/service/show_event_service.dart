import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/show_event_module/model/event_details_model.dart';
import 'package:where_hearts_meet/show_event_module/model/events_list_model.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class ShowEventApiService {
  final ApiService _apiService = ApiService();

  Future<List<EventsListModel>> getAllEvents() async {
    String url = AppUrls.allEventsUrl;
    final response = await _apiService.getApiCall(
      url: url,
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

  Future<List<EventsListModel>> getAllEventsCreatedForMe() async {
    String url = AppUrls.getAllEventsCreatedForUserUrl;
    final response = await _apiService.getApiCall(
      url: url,
      queryParams: {
        "receiver_phone_number": 9889617848
      }
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

  Future<EventDetailsModel> getEventDetails({required String eventId}) async {
    String url = AppUrls.createEventUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams: {'eventid': eventId},
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('event found')) {
      return EventDetailsModel.fromJson(data['data']);
    } else {
      return EventDetailsModel(eventid: '-1');
    }
  }
}
