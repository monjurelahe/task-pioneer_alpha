// lib/services/github_service.dart

import 'package:dio/dio.dart';
import '../models/repository.dart';

class GitHubService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.github.com'));

  Future<List<Repository>> fetchFlutterRepositories() async {
    try {
      final response = await _dio.get(
        '/search/repositories',
        queryParameters: {
          'q': 'Flutter',
          'sort': 'stars',
          'order': 'desc',
          'per_page': 50,
        },
      );

      final List items = response.data['items'];
      return items.map((json) => Repository.fromJson(json)).toList();
    } on DioException catch (e) {
      // Proper error handling for API failures [cite: 37]
      throw Exception('Failed to load repositories: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
