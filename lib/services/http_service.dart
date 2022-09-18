import 'package:dio/dio.dart';
import 'package:flutter_movies/models/app_config.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();
  final getIt = GetIt.instance;

  late String _base_url;
  late String _api_key;

  HTTPService() {
    AppConfig config = getIt.get<AppConfig>();
    _base_url = config.BASE_URL;
    _api_key = config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_base_url$path';
      Map<String, dynamic> query = {'api_key': _api_key, 'language': 'en-US'};
      query.addAll(query);
      return await dio.get(url, queryParameters: query);
    } on DioError catch (e) {
      print('Unable to perform the request : $e');
      return null;
    }
  }
}
