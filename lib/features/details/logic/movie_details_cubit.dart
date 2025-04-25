import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/favorite_movie_repository.dart';
import '../../../data/repository/movie_repository.dart';
import 'movie_details_state.dart';
import '../../../data/model/movie.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;
  final FavMovieRepository favRepository;

  MovieDetailsCubit(this.repository, this.favRepository) : super(MovieDetailsInitial());

  late Movie _movie;
  bool _isFavorite = false;

  Movie get movie => _movie;
  bool get isFavorite => _isFavorite;

  Future<void> fetchMovieDetails(String movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await repository.getMovieDetails(movieId);
      if (movie != null) {
        _movie = movie;
        _isFavorite = await favRepository.isFavorite(movie.id);
        emit(MovieDetailsSuccess(movie: movie, isFavorite: _isFavorite));
      } else {
        emit(MovieDetailsFailure("Movie not found"));
      }
    } catch (e) {
      emit(MovieDetailsFailure("Failed to fetch movie details"));
    }
  }

  Future<void> toggleFavorite() async {
    if (_isFavorite) {
      await favRepository.removeFromFavorites(_movie.id);
    } else {
      await favRepository.addToFavorites(_movie);
    }
    _isFavorite = !_isFavorite;
    emit(MovieDetailsSuccess(movie: _movie, isFavorite: _isFavorite));
  }
}
