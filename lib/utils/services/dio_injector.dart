import 'dart:developer';

import 'package:dio/dio.dart';

import '../consts/api_urls.dart';

class DioInjector {
  late Dio _dio;

  DioInjector() {
    init();
  }

  Dio get dio => _dio;

  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: AppUrls.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors
      ..add(CustomInterceptor())
      ..add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          request: false,
          responseHeader: false,
        ),
      );
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('OnError ${err.message}');
    return handler.next(err);
  }
}
