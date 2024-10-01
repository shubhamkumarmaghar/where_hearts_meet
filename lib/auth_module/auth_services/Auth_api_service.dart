import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../auth_model/login_response_model.dart';

class AuthApiService {
  final ApiService _apiService = ApiService();

  Future<LoginResponseModel> fetchLoginUser(
      {required String phoneNumber, required String uid, bool isGuest = false}) async {
    String url = AppUrls.loginUrl;
    final token = await FirebaseMessaging.instance.getToken();
    final response = await _apiService.postApiCallForLogin(
      url: url,
      data: {
        'phone_number': phoneNumber,
        'uid': uid,
        'is_guest': isGuest,
        'is_ios': Platform.isIOS,
        'fcm_token': token
      },
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('failure')) {
      return LoginResponseModel(message: 'failure');
    } else {
      final loginData = LoginResponseModel.fromJson(data);
      return loginData;
    }
  }
}
