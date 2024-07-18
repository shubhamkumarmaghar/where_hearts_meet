import 'package:where_hearts_meet/profile_module/model/user_model.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';

class ProfileService {
  final ApiService _apiService = ApiService();

  Future<UserModel?> userDataApi() async {
    String url = AppUrls.userAccountUrl;
    final response = await _apiService.getApiCall(
      url: url,
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('events found') && data['data'] != null) {
      return UserModel.fromJson(data['data']);
    } else {
      return null;
    }
  }

  Future<UserModel?> updateUserDataApi(
      {String? firstName,
      String? lastName,
      String? email,
      String? dateOfBirth,
      String? address,
      String? gender,
      String? martialStatus,
      String? profilePic}) async {
    String url = AppUrls.signUpUrl;
    final response = await _apiService.patchApiCall(url: url, data: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "date_of_birth": dateOfBirth,
      "address": address,
      "gender": gender,
      "marital_status": martialStatus,
      "profile_pic": profilePic,
    });
    final data = response;

    if (data['message'].toString().toLowerCase().contains('events found') && data['data'] != null) {
      return UserModel.fromJson(data['data']);
    } else {
      return null;
    }
  }
}
