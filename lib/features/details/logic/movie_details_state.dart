part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final Movie movie;
  MovieDetailsSuccess(this.movie);
}

class MovieDetailsFailure extends MovieDetailsState {
  final String error;
  MovieDetailsFailure(this.error);
}