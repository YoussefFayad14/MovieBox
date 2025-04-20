import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/MovieRepository.dart';
import '../../home/presentation/home_screen.dart';
import '../../home/widget/error_view.dart';
import '../logic/movie_details_cubit.dart';
import '../logic/movie_details_state.dart';
import '../logic/similar_movies_cubit.dart';
import '../logic/similar_movies_state.dart';
import '../logic/recommended_movies_cubit.dart';
import '../logic/recommended_movies_state.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late final MovieRepository _repository;
  late final MovieDetailsCubit _movieDetailsCubit;
  late final SimilarMoviesCubit _similarMoviesCubit;
  late final RecommendedMoviesCubit _recommendedMoviesCubit;

  @override
  void initState() {
    super.initState();
    _repository = MovieRepository();
    _movieDetailsCubit = MovieDetailsCubit(_repository)..fetchMovieDetails(widget.id);
    _similarMoviesCubit = SimilarMoviesCubit(_repository)..fetchSimilarMovies(widget.id);
    _recommendedMoviesCubit = RecommendedMoviesCubit(_repository)..fetchRecommendedMovies(widget.id);
  }

  @override
  void dispose() {
    _movieDetailsCubit.close();
    _similarMoviesCubit.close();
    _recommendedMoviesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _movieDetailsCubit),
        BlocProvider.value(value: _similarMoviesCubit),
        BlocProvider.value(value: _recommendedMoviesCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen())
              );
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // TODO: Add share logic
              },
              icon: Icon(Icons.share, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster
                BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                  builder: (context, state) {
                    if (state is MovieDetailsLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          )
                      );
                    } else if (state is MovieDetailsSuccess) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: state.movie.image,
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (state is MovieDetailsFailure) {
                      return ErrorView();
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),

                // Movie Info
                BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                  builder: (context, state) {
                    if (state is MovieDetailsSuccess) {
                      final movie = state.movie;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                              movie.title,
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Check if the movie is already favorite
                                  // If not, add it to the favorites list
                                  // If yes, remove it from the favorites list
                                },
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow, size: 24),
                              const SizedBox(width: 5),
                              Text(
                                '${movie.rating}/10',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Summary:',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            movie.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),

                // Similar Movies
                BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
                  builder: (context, state) {
                    if (state is SimilarMoviesLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          )
                      );
                    } else if (state is SimilarMoviesSuccess) {
                      return _buildMovieList(
                        title: 'Similar Movies',
                        movies: state.similarMovies,
                      );
                    } else if (state is SimilarMoviesFailure) {
                      print(state.error);
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 20),

                // Recommended Movies
                BlocBuilder<RecommendedMoviesCubit, RecommendedMoviesState>(
                  builder: (context, state) {
                    if (state is RecommendedMoviesLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          )
                      );
                    } else if (state is RecommendedMoviesSuccess) {
                      return _buildMovieList(
                        title: 'Recommended Movies',
                        movies: state.recommendedMovies,
                      );
                    } else if (state is RecommendedMoviesFailure) {
                      print(state.error);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget _buildMovieList({required String title, required List<dynamic> movies}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: movies.map((movie) {
            return Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              elevation: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                    child: CachedNetworkImage(
                      imageUrl: movie.image,
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          movie.date,
                          style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 16.0),
                            const SizedBox(width: 4.0),
                            Text(
                              '${movie.rating.toStringAsFixed(1)}',
                              style: const TextStyle(color: Colors.yellow, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      )
    ],
  );
}

