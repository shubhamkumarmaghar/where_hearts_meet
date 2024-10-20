import 'package:get_storage/get_storage.dart';
import 'package:heart_e_homies/utils/consts/screen_const.dart';

import '../../create_event/model/event_response_model.dart';
import '../../create_event/model/wishes_model.dart';
import '../../utils/consts/api_urls.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/services/api_service.dart';

class EventListService {
  final ApiService _apiService = ApiService();

  Future<List<EventResponseModel>?> fetchEventsList(EventsCreated eventsCreated) async {
    String url = AppUrls.eventsCreatedByUserUrl;
    final storage = GetStorage();
    var userPhone = storage.read(userMobile) ?? '';
    Map<String, dynamic> queryParam = {"receiver_phone_number": userPhone};

    if (eventsCreated == EventsCreated.wishlist) {
      url = AppUrls.wishlistUrl;
    } else if (eventsCreated == EventsCreated.byUser) {
      url = AppUrls.eventsCreatedByUserUrl;
    } else if (eventsCreated == EventsCreated.forUser) {
      url = AppUrls.eventsCreatedForUserUrl;
    } else if (eventsCreated == EventsCreated.pending) {
      url = AppUrls.pendingEventsByUserUrl;
    }

    final response = await _apiService.getApiCall(url: url, queryParams: queryParam);
    final data = response;

    if (data['message'].toString().toLowerCase().contains('found') && data['data'] != null) {
      Iterable iterable = data['data'];
      final list = iterable.map((event) => EventResponseModel.fromJson(event)).toList();
      return list;
    } else {
      return null;
    }
  }

  Future<bool> wishListEvent(String eventId) async {
    String url = AppUrls.wishlistUrl;
    final response = await _apiService.postApiCall(url: url, data: {
      "event_id": eventId,
    });
    return response['message'].toString().toLowerCase().contains('added to wishlist');
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
}
