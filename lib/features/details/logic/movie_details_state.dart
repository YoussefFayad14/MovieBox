import '../../../data/model/movie.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final Movie movie;
  final bool isFavorite;

  MovieDetailsSuccess({required this.movie, required this.isFavorite});
}

class MovieDetailsFailure extends MovieDetailsState {
  final String error;
  MovieDetailsFailure(this.error);
}