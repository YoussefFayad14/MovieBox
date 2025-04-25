import 'package:flutter/material.dart';
import '../../../data/model/movie.dart';
import '../../details/presentation/movie_details_screen.dart';
import 'movie_card.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          (context, index) {
          final movie = movies[index];
          return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MovieDetailsScreen(id: movie.id.toString()))
                );
              },
            child: MovieCard(movie: movie),
          );
        },
        childCount: movies.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 10,
      ),
    );
  }
}
