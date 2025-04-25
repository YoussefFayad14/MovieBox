import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/movie_repository.dart';
import '../../../data/model/movie.dart';
import 'recommended_movies_state.dart';

class RecommendedMoviesCubit extends Cubit<RecommendedMoviesState> {
  final MovieRepository repository;

  RecommendedMoviesCubit(this.repository) : super(RecommendedMoviesInitial());

  Future<void> fetchRecommendedMovies(String movieId) async {
    emit(RecommendedMoviesLoading());
    try {
      final rawList = await repository.fetchRecommendedMovies(movieId);
      final movies = rawList.map((e) => Movie.fromJson(e)).toList();
      if (movies.isNotEmpty) {
        emit(RecommendedMoviesSuccess(recommendedMovies: movies));
      } else {
        emit(RecommendedMoviesFailure("No recommended movies found"));
      }
    } catch (e) {
      emit(RecommendedMoviesFailure("Failed to fetch recommended movies $e"));
    }
  }
}
