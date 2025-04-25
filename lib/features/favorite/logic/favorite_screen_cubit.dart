import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/movie.dart';
import '../../../data/repository/favorite_movie_repository.dart';
part 'favorite_screen_state.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteScreenState> {
  final FavMovieRepository favRepository;

  FavoriteMoviesCubit(this.favRepository) : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    try {
      final movies = await favRepository.getFavorites();
      emit(FavoriteSuccess(favoriteMovies: movies));
    } catch (e) {
      emit(FavoriteFailure("Failed to load favorite movies."));
    }
  }

  Future<void> removeFavorite(int id) async {
    await favRepository.removeFromFavorites(id);
    loadFavorites();
  }

}

