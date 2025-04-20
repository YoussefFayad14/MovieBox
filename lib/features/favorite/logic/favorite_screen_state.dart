part of 'favorite_screen_cubit.dart';

abstract class FavoriteScreenState {}

class FavoriteInitial extends FavoriteScreenState {}

class FavoriteLoading extends FavoriteScreenState {}

class FavoriteSuccess extends FavoriteScreenState {
  final List<Movie> favoriteMovies;

  FavoriteSuccess({required this.favoriteMovies});
}

class FavoriteFailure extends FavoriteScreenState {
  final String error;
  FavoriteFailure(this.error);
}

