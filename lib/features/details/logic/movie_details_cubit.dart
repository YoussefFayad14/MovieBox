import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviebox/data/repository/MovieRepository.dart';

import '../../../data/model/movie.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;

  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());
  Future<void> fetchMovieDetails(String movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await repository.getMovieDetails(movieId);
      if (movie != null) {
        emit(MovieDetailsSuccess(movie));
      } else {
        emit(MovieDetailsFailure("Movie not found"));
      }
    } catch (e) {
      emit(MovieDetailsFailure("Failed to fetch movie details"));
    }
  }
}
