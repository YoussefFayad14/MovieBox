import '../../../data/model/movie.dart';

abstract class RecommendedMoviesState {}

class RecommendedMoviesInitial extends RecommendedMoviesState {}

class RecommendedMoviesLoading extends RecommendedMoviesState {}

class RecommendedMoviesSuccess extends RecommendedMoviesState {
  final List<Movie> recommendedMovies;
  RecommendedMoviesSuccess({required this.recommendedMovies});
}

class RecommendedMoviesFailure extends RecommendedMoviesState {
  final String error;
  RecommendedMoviesFailure(this.error);
}
