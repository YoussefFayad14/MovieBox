import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/MovieRepository.dart';
import '../../../data/model/movie.dart';
import 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final MovieRepository repository;

  SimilarMoviesCubit(this.repository) : super(SimilarMoviesInitial());

  Future<void> fetchSimilarMovies(String movieId) async {
    emit(SimilarMoviesLoading());
    try {
      final rawList = await repository.fetchSimilarMovies(movieId);
      final movies = rawList.map((e) => Movie.fromJson(e)).toList();
      if (movies.isNotEmpty) {
        emit(SimilarMoviesSuccess(similarMovies: movies));
      } else {
        emit(SimilarMoviesFailure("No similar movies found"));
      }
    } catch (e) {
      emit(SimilarMoviesFailure("Failed to fetch similar movies $e"));
    }
  }
}
