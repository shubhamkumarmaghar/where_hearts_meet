import 'package:heart_e_homies/create_event/model/event_response_model.dart';
import 'package:heart_e_homies/view_event_details/personal_wishes/model/personal_wishes_model.dart';

import '../../create_event/model/gift_model.dart';
import '../../create_event/model/personal_decorations_model.dart';
import '../../create_event/model/personal_memories_model.dart';
import '../../create_event/model/personal_messages_model.dart';
import '../../create_event/model/wishes_model.dart';
import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class ViewEventService {
  final ApiService _apiService = ApiService();

  Future<EventResponseModel?> getEventDetails(
      {required String eventId, required String mobileNo, bool eventFor = true}) async {
    String url = eventFor == false ? AppUrls.receiveEventUrl : AppUrls.createEventUrl;

    Map<String, dynamic> queryParams = {'eventid': eventId};
    if (eventFor == false) {
      queryParams.addAll({'receiver_phone_number': mobileNo});
    }

    final response = await _apiService.getApiCall(
      url: url,
      queryParams: queryParams,
    );

    if (response['message'].toString().toLowerCase().contains('event found') && response['data'] != null) {
      return EventResponseModel.fromJson(response['data']);
    } else {
      return null;
    }
  }

  Future<List<GiftModel>?> getEGiftsApi({required String eventId}) async {
    String url = AppUrls.giftsUrl;

    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().toLowerCase().contains('gifts found') && data['data'] != null) {
      Iterable iterable = data['data'] as Iterable;
      return iterable.map((e) => GiftModel.fromJson(e)).toList();
    }
    return null;
  }

  Future<List<WishesModel>?> fetchWishesList({required String eventId}) async {
    String url = AppUrls.eventWishesUrl;

    final response = await _apiService.getApiCall(
      url: url,
      queryParams: {
        'event_id': eventId,
      },
    );
    final data = response;
    if (data['message'].toString().toLowerCase().contains('wishes found') && data['data'] != null) {
      Iterable iterable = data['data'];
      return iterable.map((element) => WishesModel.fromJson(element)).toList();
    } else {
      return null;
    }
  }

  Future<PersonalWishesCoverModel?> personalWishesApi({required String eventId}) async {
    String url = AppUrls.personalWises;
    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().contains('Personal Wishes found') && data['data'] != null) {
      var personalWishesModel = PersonalWishesCoverModel.fromJson(data['data']);
      return personalWishesModel;
    } else {
      return null;
    }
  }

  Future<List<PersonalMemoriesModel>?> getPersonalMemoriesApi({required String eventId}) async {
    String url = AppUrls.personaMemoriesUrl;

    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().contains('Personal memories found') && data['data'] != null) {
      Iterable iterable = data['data'];
      return iterable.map((element) => PersonalMemoriesModel.fromJson(element)).toList();
    }
    return null;
  }

  Future<PersonalMessagesModel?> getPersonalMessagesApi({required String eventId}) async {
    String url = AppUrls.personaMessagesUrl;

    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().toLowerCase().contains('personal messages found') && data['data'] != null) {
      return PersonalMessagesModel.fromJson(data['data']);
    }
    return null;
  }

  Future<PersonalDecorationsModel?> getPersonalDecorationsApi({required String eventId}) async {
    String url = AppUrls.personalDecorationsUrl;

    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().toLowerCase().contains('found') && data['data'] != null) {
      return PersonalDecorationsModel.fromJson(data['data']);
    }
    return null;
  }
}
