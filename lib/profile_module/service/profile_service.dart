import 'dart:developer';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import '../../utils/consts/api_urls.dart';
import '../../utils/consts/shared_pref_const.dart';
import '../../utils/model/image_response_model.dart';
import '../../utils/services/api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

import '../model/user_model.dart';

class ProfileService {
  final ApiService _apiService = ApiService();

  Future<ImageResponseModel?> uploadImageApi({required File imageFile}) async {
    final img = await dio.MultipartFile.fromFile(imageFile.path,
        filename: (imageFile.path.split('/')).last, contentType: MediaType('image', (imageFile.path.split('.')).last));

    final response = await _apiService.formDataPostApiCall(url: AppUrls.uploadFileUrl, data: {'file': img});

    return response['data'] != null ? ImageResponseModel.fromJson(response['data']) : null;
  }

  Future<UserModel?> userDataApi() async {
    String url = AppUrls.userAccountUrl;
    final response = await _apiService.getApiCall(
      url: url,
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('user data') && data['data'] != null) {
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

    final response = await _apiService.putApiCall(url: url, data: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "date_of_birth": dateOfBirth,
      "address": address,
      "gender": gender,
      "marital_status": martialStatus,
      "phone_number": GetStorage().read(userMobile),
      "username": GetStorage().read(username),
      "profile_pic": profilePic,
    });
    final data = response;

    if (data['message'].toString().toLowerCase().contains('successful') && data['data'] != null) {
      return UserModel.fromJson(data['data']);
    } else {
      return null;
    }
  }
}
