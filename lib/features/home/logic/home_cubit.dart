import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/movie.dart';
import '../../../data/repository/movie_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository repository;

  List<Movie> _trendingMovies = [];
  List<Movie> _categoryMovies = [];

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> fetchTrendingMovies() async {
    emit(HomeLoading());
    try {
      final trending = await repository.getTrendingMovies();
      _trendingMovies = trending.map((movie) => Movie.fromJson(movie)).toList();

      final defaultMovies = await repository.getTvSeries();
      _categoryMovies = defaultMovies.map((movie) => Movie.fromJson(movie)).toList();

      emit(HomeSuccess(
        trendingMovies: _trendingMovies,
        categoryMovies: _categoryMovies,
      ));
    } catch (e) {
      emit(HomeFailure("Failed to fetch trending movies"));
    }
  }

  Future<void> fetchTvSeries() async {
    emit(HomeLoading());
    try {
      final series = await repository.getTvSeries();
      _categoryMovies = series.map((movie) => Movie.fromJson(movie)).toList();
      emit(HomeSuccess(
        trendingMovies: _trendingMovies,
        categoryMovies: _categoryMovies,
      ));
    } catch (e) {
      emit(HomeFailure("Failed to fetch TV series"));
    }
  }

  Future<void> fetchMovies() async {
    emit(HomeLoading());
    try {
      final movies = await repository.getMovies();
      _categoryMovies = movies.map((movie) => Movie.fromJson(movie)).toList();
      emit(HomeSuccess(
        trendingMovies: _trendingMovies,
        categoryMovies: _categoryMovies,
      ));
    } catch (e) {
      emit(HomeFailure("Failed to fetch movies"));
    }
  }

  Future<void> fetchUpcoming() async {
    emit(HomeLoading());
    try {
      final upcoming = await repository.getUpcoming();
      _categoryMovies = upcoming.map((movie) => Movie.fromJson(movie)).toList();
      emit(HomeSuccess(
        trendingMovies: _trendingMovies,
        categoryMovies: _categoryMovies,
      ));
    } catch (e) {
      emit(HomeFailure("Failed to fetch upcoming movies"));
    }
  }

}
