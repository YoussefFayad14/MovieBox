import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/MovieRepository.dart';
import 'movie_details_state.dart';
import '../../../data/model/movie.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;

  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());
  Future<void> fetchMovieDetails(String movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movie = await repository.getMovieDetails(movieId);
      if (movie != null) {
        emit(MovieDetailsSuccess(movie: movie));
      } else {
        emit(MovieDetailsFailure("Movie not found"));
      }
    } catch (e) {
      emit(MovieDetailsFailure("Failed to fetch movie details"));
    }
  }
}
