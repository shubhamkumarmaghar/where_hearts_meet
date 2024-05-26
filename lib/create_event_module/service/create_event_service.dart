import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../model/create_event_model.dart';

class EventApiService {
  final ApiService _apiService = ApiService();

  Future<CreateEventResponseModel> createEvent(
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
        'event_name': eventName ?? "",
        'host_name': hostName ?? "",
        'event_type': eventType ?? "",
        'event_host_day': eventHostDay ?? "",
        'event_subtext': eventSubtext ?? "",
        'event_description': eventDescription ?? "",
        'phone_number': mobileNo ?? "",
        'username': username ?? "",
        "pic":imageFiles
      },
    );
    final data = response;

    if (data['message']
        .toString()
        .toLowerCase()
        .contains('Event created successfully')) {
      log('data :: $data');
      return CreateEventResponseModel.fromJson(data);
    } else {
      return CreateEventResponseModel(message: 'failure');
    }
  }
}
