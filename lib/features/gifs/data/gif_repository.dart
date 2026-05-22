import 'package:dio/dio.dart';
import 'giphy_api.dart';
import 'models/gif_item.dart';

class GifRepository {
  final GiphyApi _api;
  GifRepository(this._api);
  Future<List<GifItem>> searchGifs({required String query, int limit = 25, int offset = 0}) async {
    try {
      final response = await _api.searchGifs(query: query, limit: limit, offset: offset);
      final responseData = response.data['data'] as Map<String, dynamic>;
      final gifsJson = responseData['data'] as List<dynamic>;
      return gifsJson.map((json) => GifItem.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load GIFs: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}