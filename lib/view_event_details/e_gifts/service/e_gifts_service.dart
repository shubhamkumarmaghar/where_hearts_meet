

import '../../../create_event/model/gift_model.dart';
import '../../../utils/consts/api_urls.dart';
import '../../../utils/services/api_service.dart';

class EGiftsService {
  final ApiService _apiService = ApiService();

  Future<List<GiftModel>?> getEGiftsApi({required String eventId}) async {
    String url = AppUrls.giftsUrl;

    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().toLowerCase().contains('gifts found ') && data['data'] != null) {
      Iterable iterable = data['data'] as Iterable;
      return iterable.map((e) => GiftModel.fromJson(e)).toList();
    }
    return null;
  }
}
