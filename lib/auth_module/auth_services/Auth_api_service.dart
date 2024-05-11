import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../auth_model/login_response_api.dart';
import '../auth_model/response_register_model.dart';

class AuthApiService {
  ApiService _apiService = ApiService();

  Future<RegisterResponseModel> registerUser(
      {required String email,
      required String password,
      required username}) async {
    String url = AppUrls.registerUrl;
    final response = await _apiService.postApiCall(
      url: url,
      data: {'email': email, 'password': password, 'username': username},
    );
    final data = response;

    if (data['msg'].toString().toLowerCase().contains('failure')) {
      return RegisterResponseModel(message: 'failure');
    } else {
      return RegisterResponseModel.fromJson(data);
    }
  }

  Future<LoginResponseApi> fetchLoginUser({
    required String email,
    required String password,
  }) async {
    String url = AppUrls.loginUrl;
    final response = await _apiService.postApiCall(
      url: url,
      data: {
        'username': email,
        'password': password,
      },
    );
    final data = response;

    if (data['msg'].toString().toLowerCase().contains('failure')) {
      return LoginResponseApi(message: 'failure');
    } else {
      return LoginResponseApi.fromJson(data);
    }
  }

  Future<LoginResponseApi> SignUpUser(
      {required String email,
      required String firstName,
      required String lastName,
      required String date_of_birth,
      required String address,
      required String city,
      required String state,
      required String country,
      required String postalCode,
      required String phoneNumber,
      required String maritalStatus,
      required String profile_pic,
      required String username,
        required String gender,
      }) async {
    String url = AppUrls.signUpUrl;
    final response = await _apiService.patchApiCall(
      url: url,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': date_of_birth,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
        'postal_code': postalCode,
        'phone_number': phoneNumber,
        'marital_status': maritalStatus,
        'profile_pic_url': profile_pic,
        'email': email,
        'username':username,
        'gender':gender
      },
    );
    final data = response;

    if (data['msg'].toString().toLowerCase().contains('failure')) {
      return LoginResponseApi(message: 'failure');
    } else {
      return LoginResponseApi.fromJson(data);
    }
  }
}