import 'package:moviebox/data/model/movie.dart';
import '../remote/movie_service.dart';

class MovieRepository {
  final MovieService _movieService = MovieService();

  Future<List<dynamic>> getTrendingMovies() {
    return _movieService.getTrendingMovies();
  }

  Future<List<dynamic>> getTvSeries() {
    return _movieService.getTvSeries();
  }

  Future<List<dynamic>> getMovies() {
    return _movieService.getMovies();
  }

  Future<List<dynamic>> getUpcoming() {
    return _movieService.getUpcoming();
  }

  Future<Movie?>? getMovieDetails(String id){
    return _movieService.getMovieDetails(id);
  }

  Future<List<dynamic>> fetchSimilarMovies(String id) {
    return _movieService.fetchSimilarMovies(id);
  }

  Future<List<dynamic>> fetchRecommendedMovies(String id) {
    return _movieService.fetchRecommendedMovies(id);
  }

}
