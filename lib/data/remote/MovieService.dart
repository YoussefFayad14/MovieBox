import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/movie.dart';

class MovieService {
  final String _apiKey = '1092e13814b0e9ba901b29b83cb98e49';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  )..interceptors.add(PrettyDioLogger());

  Future<List<dynamic>> getTrendingMovies() async {
    try {
      final response = await _dio.get(
        '/trending/all/week',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['results'];
      } else {
        print("No Data");
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load trending movies: $e');
    }
  }

  Future<List<dynamic>> getTvSeries() async {
    try {
      final response = await _dio.get(
        '/tv/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['results'];
      } else {
        print("No TV series data");
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load TV series: $e');
    }
  }

  Future<List<dynamic>> getMovies() async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['results'];
      } else {
        print("No movies data");
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<List<dynamic>> getUpcoming() async {
    try {
      final response = await _dio.get(
        '/movie/upcoming',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['results'];
      } else {
        print("No upcoming movies data");
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load upcoming movies: $e');
    }
  }


  Future<Movie?> getMovieDetails(String movieId) async {
    try {
      final response = await _dio.get(
        '/movie/$movieId',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'en-US',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return Movie.fromJson(response.data);
      } else {
        print('No movie found!!');
        return null;
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

}
