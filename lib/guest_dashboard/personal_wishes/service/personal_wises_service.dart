import '../../../create_event/model/personal_memories_model.dart';
import '../../../utils/consts/api_urls.dart';
import '../../../utils/services/api_service.dart';
import '../model/personal_wishes_model.dart';

class PersonalWishesService {
  final ApiService _apiService = ApiService();

  Future<PersonalWishesCoverModel?> personalWishesApi(
      {required String eventId}) async {
    String url = AppUrls.personalWises;
    final response = await _apiService
        .getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message']
            .toString()
            .contains('Personal Wishes found successfully.') &&
        data['data'] != null) {
      //  Iterable iterable = data['data'];
      // final list = iterable.map((event) => PersonalWishesCoverModel.fromJson(event)).toList();
      var personalWishesModel = PersonalWishesCoverModel.fromJson(data['data']);
      return personalWishesModel;
    } else {
      return null;
    }
  }

  Future<List<PersonalMemoriesModel>?> getPersonalMemoriesApi(
      {required String eventId}) async {
    String url = AppUrls.personaMemoriesUrl;

    final response = await _apiService
        .getApiCall(url: url, queryParams: {'event_id': eventId});
    final data = response;

    if (data['message']
        .toString()
        .contains('Personal memories found successfully.') && data['data'] != null) {
      Iterable iterable = data['data'];
      return iterable
          .map((element) => PersonalMemoriesModel.fromJson(element))
          .toList();
    }
    return null;
  }
}
