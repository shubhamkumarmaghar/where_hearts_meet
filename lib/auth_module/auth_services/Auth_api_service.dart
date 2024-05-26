import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../auth_model/login_response_model.dart';
import '../auth_model/response_register_model.dart';

class AuthApiService {
  final ApiService _apiService = ApiService();

  Future<RegisterResponseModel> registerUser(
      {required String email, required String password, required String mobileNumber, required username}) async {
    String url = AppUrls.registerUrl;

    final response = await _apiService.postApiCallForLogin(
      url: url,
      data: {'email': email, 'password': password, 'first_name': username, 'phone_number': mobileNumber},
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('failure')) {
      return RegisterResponseModel(message: 'failure');
    } else {
      return RegisterResponseModel.fromJson(data);
    }
  }

  Future<LoginResponseModel> fetchLoginUser({
    required String phoneNumber,
    required String password,
  }) async {
    String url = AppUrls.loginUrl;
    final response = await _apiService.postApiCallForLogin(
      url: url,
      data: {
        'phone_number': phoneNumber,
        'password': password,
      },
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('failure')) {
      return LoginResponseModel(message: 'failure');
    } else {
      return LoginResponseModel.fromJson(data);
    }
  }

  Future<LoginResponseModel> SignUpUser({
    required String email,
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
        'username': username,
        'gender': gender
      },
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('failure')) {
      return LoginResponseModel(message: 'failure');
    } else {
      return LoginResponseModel.fromJson(data);
    }
  }
}
