
import 'dart:developer';

import '../../../../show_event_module/model/event_details_model.dart';
import '../../../../utils/consts/api_urls.dart';
import '../../../../utils/services/api_service.dart';
import '../../model/timeline_model.dart';
import '../../model/wisheh_model.dart';

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

  Future<WishesModel>getWishesList({required String eventId}) async {
    String url = AppUrls.receiveWishsUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams:{
        'event_id': eventId,
      } ,

    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('wishes found successfully')) {
      return WishesModel.fromJson(data);
    } else {
      return WishesModel();
    }

  }

  Future<TimeLineModel>getTimeline({required String eventId}) async {
    String url = AppUrls.eventTimelineUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams:{
        'event_id': eventId,
      } ,

    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('timeline found successfully')) {
      return TimeLineModel.fromJson(data);
    } else {
      return TimeLineModel();
    }

  }
}