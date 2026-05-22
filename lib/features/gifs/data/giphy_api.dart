import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';

class GiphyApi {
  final Dio _dio;
  GiphyApi(this._dio);
  Future<Response<dynamic>> searchGifs({
    required String query,
    int limit = 25,
    int offset = 0,
  }) async {
    return _dio.get(
      '${AppConfig.giphyBaseUrl}/search',
      queryParameters: {
        'api_key': AppConfig.giphyApiKey,
        'q': query,
        'limit': limit,
        'offset': offset,
        'rating': 'g',
      },
    );
  }
}