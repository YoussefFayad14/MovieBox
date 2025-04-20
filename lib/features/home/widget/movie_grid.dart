import 'package:flutter/material.dart';
import '../../../data/model/movie.dart';
import 'movie_card.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        },
        childCount: movies.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 12, // Space between columns
        mainAxisSpacing: 10, // Space between rows
      ),
    );
  }
}
