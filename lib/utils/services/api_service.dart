import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/consts/service_const.dart';
import 'package:where_hearts_meet/utils/consts/shared_pref_const.dart';
import 'package:where_hearts_meet/utils/services/dio_injector.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';

class ApiService {
  final apiClient = locator<DioInjector>();

  Map<String, dynamic> getHeaders() {
    String userToken = GetStorage().read(token) ??'';
    log('Authorization Bearer $userToken');
    return {
      'Authorization':'Bearer $userToken'

    };
  }

  Future<Map<String, dynamic>> getApiCall({required String url, Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await apiClient.dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: getHeaders()),
      );
      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }

  Future<Map<String, dynamic>> postApiCall({required String url, required Map<String, dynamic> data}) async {
    try {
      Response response = await apiClient.dio.post(
        url,
        data: data,
        options: Options(headers: getHeaders()),
      );

      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }
  Future<Map<String, dynamic>> formDataPostApiCall({required String url, required Map<String, dynamic> data}) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response response = await apiClient.dio.post(
        url,
        data: formData,
        options: Options(headers: getHeaders()),
      );

      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }

  Future<Map<String, dynamic>> postApiCallForLogin({required String url, required Map<String, dynamic> data}) async {
    try {
      Response response = await apiClient.dio.post(
        url,
        data: data,
       // options: Options(headers: getHeaders()),
      );

      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }

  Future<Map<String, dynamic>> putApiCall({required String url, required Map<String, dynamic> data}) async {
    try {
      Response response = await apiClient.dio.put(
        url,
        data: data,
        options: Options(
          headers: getHeaders(),
        ),
      );
      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }

  Future<Map<String, dynamic>> patchApiCall({required String url, required Map<String, dynamic> data}) async {
    try {
      log('data :: $data');
     //FormData formData = FormData.fromMap(data);

      Response response = await apiClient.dio.patch(
        url,
        data: jsonEncode({'first_name':'Deepak'}),
        options: Options(
          headers: getHeaders(),
        ),
      );

      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }

  Future<Map<String, dynamic>> deleteApiCall({required String url}) async {
    try {
      Response response = await apiClient.dio.delete(
        url,
        options: Options(headers: getHeaders()),
      );
      return await _handleResponse(response: response, url: url);
    } catch (e) {
      log('Error :: ${e.toString()}');
      return {'message': 'failure'};
    }
  }

  Future<Map<String, dynamic>> _handleResponse({
    required Response response,
    String? url,
  }) async {
    log('Status Code :: ${response.statusCode} -- $url    ${response.data}');
    switch (response.statusCode) {
      case 200:
        return response.data.isNotEmpty ? response.data : {'message': 'failure'};
      case 201:
        return response.data.isNotEmpty ? response.data : {'message': 'failure'};
      case 400:
        return _getErrorResponse(json.decode(response.data));
      case 401:
        return _getErrorResponse(json.decode(response.data));
      case 402:
        return _getErrorResponse(json.decode(response.data));
      case 403:
        return _getErrorResponse(json.decode(response.data));
      case 404:
        return _getErrorResponse(json.decode(response.data));
      case 405:
        return _getErrorResponse(json.decode(response.data));
      case 415:
        return _getErrorResponse(json.decode(response.data));
      case 500:
        return _getErrorResponse(json.decode(response.data));
      case 501:
        return _getErrorResponse(json.decode(response.data));
      case 502:
        return _getErrorResponse(json.decode(response.data));
      default:
        return _getErrorResponse(json.decode(response.data));
    }
  }

  Map<String, dynamic> _getErrorResponse(decode) {
    final error = decode as Map<String, dynamic>;
    AppWidgets.getToast(message: 'Error : ${error['message']}', color: redColorError);
    return {'message': 'failure ${error['message']}'};
  }
}
