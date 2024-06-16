import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:where_hearts_meet/show_event_module/model/event_details_model.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../model/create_event_model.dart';

class EventApiService {
  final ApiService _apiService = ApiService();

  Future<EventDetailsModel> createEvent(
      {required String eventName,
      required String hostName,
      required String eventType,
      required String eventHostDay,
      required String eventSubtext,
      required String eventDescription,
      required String mobileNo,
        required List<MultipartFile> imageFiles,
      required String username}) async {
    String url = AppUrls.createEventUrl;
    final response = await _apiService.formDataPostApiCall(
      url: url,
      data: {
        'event_name': eventName,
        'receiver_name': hostName,
        'event_type': eventType,
        'event_host_day': eventHostDay,
        'event_subtext': eventSubtext,
        'event_description': eventDescription,
        'receiver_phone_number': mobileNo,
        'username': username,
        "pic":imageFiles
      },
    );
    final data = response;

    if (data['message']
        .toString()
        .toLowerCase()
        .contains('event created successfully')) {
      return EventDetailsModel.fromJson(data['data']);
    } else {
      return EventDetailsModel(eventid: '-1');
    }
  }
  Future<dynamic> submitEventWishes(
      {required String eventId,
        required List<MultipartFile> imageFiles,
        required List<String> videoFiles}) async {

    String url = AppUrls.eventWishesUrl;
    final response = await _apiService.formDataPostApiCall(
      url: url,
      data: {
        'event_id': eventId ,
        'images': imageFiles,
        'videos':videoFiles,
      },
    );
    final data = response;

    if (data['message']
        .toString()
        .toLowerCase()
        .isNotEmpty) {
      log('data :: $data');
      return data['message'];
    } else {
      return data;
    }
  }
}
