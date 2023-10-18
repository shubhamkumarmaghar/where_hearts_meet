import 'package:dio/dio.dart';
import 'package:where_hearts_meet/utils/services/whm_repository.dart';

class WHMApiService extends WHMRepository {
  final Dio dio;

  WHMApiService({required this.dio});

  @override
  Future getApiCall({required String url, required String pathParam}) {
    // TODO: implement getApiCall
    throw UnimplementedError();
  }

  @override
  Future postApiCall({required String url, required Map<String, dynamic> body}) {
    // TODO: implement postApiCall
    throw UnimplementedError();
  }

  @override
  Future putApiCall({required String url, required Map<String, dynamic> body}) {
    // TODO: implement putApiCall
    throw UnimplementedError();
  }

  @override
  Future deleteApiCall({required String url, required String pathParam}) {
    // TODO: implement deleteApiCall
    throw UnimplementedError();
  }
}
