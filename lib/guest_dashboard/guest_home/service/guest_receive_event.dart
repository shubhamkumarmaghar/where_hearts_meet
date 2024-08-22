
import 'dart:developer';

import '../../../../show_event_module/model/event_details_model.dart';
import '../../../../utils/consts/api_urls.dart';
import '../../../../utils/services/api_service.dart';
import '../../../create_event/model/wishes_model.dart';
import '../../model/timeline_model.dart';


class GuestReceiveService {
  final ApiService _apiService = ApiService();


  Future<EventDetailsModel> getEventDetails({required String eventId,required String mobileNo,  bool type =true}) async {

    String url = type == false ? AppUrls.receiveEventUrl: AppUrls.createEventUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams:{
        'eventid': eventId,
       if(type== false) 'receiver_phone_number': mobileNo
      } ,

    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('event found')) {
      return EventDetailsModel.fromJson(data['data']);
    } else {
      return EventDetailsModel(eventid: '-1');
    }
  }

  Future<List<WishesModel>>getWishesList({required String eventId}) async {
    String url = AppUrls.eventWishesUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams:{
        'event_id': eventId,
      } ,
    );
    final data = response;
    if (data['message'].toString().toLowerCase().contains('wishes found successfully')) {
      var wishes = data['data'] as List;
      List<WishesModel> allWishes = [];
      wishes.forEach((element) {
        allWishes.add(WishesModel.fromJson(element));
      });
      return allWishes;
    } else {
      return [];
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
      log('shubham');
      return TimeLineModel.fromJson(data['data']);
    } else {
      log('shubhamk');
      return TimeLineModel();
    }

  }
}