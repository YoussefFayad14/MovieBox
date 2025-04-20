import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviebox/data/repository/favorite_movie_repository.dart';
import '../../details/presentation/movie_details_screen.dart';
import '../logic/favorite_screen_cubit.dart';
import '../widget/favorite_movie_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavMovieRepository _repository;
  late final FavoriteMoviesCubit _favoriteMoviesCubit;

  @override
  void initState() {
    _repository = FavMovieRepository();
    _favoriteMoviesCubit = FavoriteMoviesCubit(_repository)..loadFavorites();
    super.initState();
  }

  @override
  void dispose() {
    _favoriteMoviesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteMoviesCubit>(
      create: (_) => _favoriteMoviesCubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<FavoriteMoviesCubit, FavoriteScreenState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.amber));
            } else if (state is FavoriteSuccess) {
              if (state.favoriteMovies.isEmpty) {
                return const Center(child: Text('No favorites yet.', style: TextStyle(color: Colors.white)));
              }
              return ListView.builder(
                itemCount: state.favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.favoriteMovies[index];
                  return FavoriteMovieCard(
                    movie: movie,
                    onDelete: () => context.read<FavoriteMoviesCubit>().removeFavorite(movie.id),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(id: movie.id.toString()),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is FavoriteFailure) {
              return Center(child: Text(state.error, style: const TextStyle(color: Colors.redAccent)));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

}
