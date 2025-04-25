import '../../../data/model/movie.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Movie> trendingMovies;
  final List<Movie> categoryMovies;

  HomeSuccess({required this.trendingMovies, required this.categoryMovies});
}

class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}


