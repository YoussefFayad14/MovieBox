import '../../../data/model/movie.dart';

abstract class SimilarMoviesState {}

class SimilarMoviesInitial extends SimilarMoviesState {}

class SimilarMoviesLoading extends SimilarMoviesState {}

class SimilarMoviesSuccess extends SimilarMoviesState {
  final List<Movie> similarMovies;
  SimilarMoviesSuccess({required this.similarMovies});
}

class SimilarMoviesFailure extends SimilarMoviesState {
  final String error;
  SimilarMoviesFailure(this.error);
}
