import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class PreviewEventService {
  final ApiService _apiService = ApiService();

  Future<String?> deleteWishApi({required int wishId}) async {
    String url = AppUrls.eventWishesUrl;

    final response = await _apiService.deleteApiCall(url: url, queryParams: {"wish_id": wishId});

    if (response['message'].toLowerCase().contains('wish deleted')) {
      return response['message'];
    } else {
      return null;
    }
  }
}
