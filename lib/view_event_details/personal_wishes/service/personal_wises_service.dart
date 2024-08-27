import 'package:where_hearts_meet/create_event/model/personal_decorations_model.dart';
import 'package:where_hearts_meet/create_event/model/personal_messages_model.dart';

import '../../../create_event/model/personal_memories_model.dart';
import '../../../utils/consts/api_urls.dart';
import '../../../utils/services/api_service.dart';
import '../model/personal_wishes_model.dart';

class PersonalWishesService {
  final ApiService _apiService = ApiService();

  Future<PersonalWishesCoverModel?> personalWishesApi({required String eventId}) async {
    String url = AppUrls.personalWises;
    final response = await _apiService.getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message'].toString().contains('Personal Wishes found successfully.') && data['data'] != null) {
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

    if (data['message'].toString().contains('Personal memories found successfully.') && data['data'] != null) {
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
