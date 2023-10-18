import 'dart:developer';

import 'package:dio/dio.dart';

final DioInjector injector = DioInjector();

class DioInjector {
  DioInjector() {
    init();
  }

  final _dio = Dio(BaseOptions(
    baseUrl: 'baseUrl',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
  ));

  Dio get dio => _dio;

  void init() {
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
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('OnError ${err.message}');
    return handler.next(err);
  }
}
