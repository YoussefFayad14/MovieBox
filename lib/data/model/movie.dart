class Movie {
  final int id;
  final String title;
  final String image;
  final String date;
  final double rating;
  final String overview;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.rating,
    required this.overview,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? '',
      image: "https://image.tmdb.org/t/p/w500${json['poster_path']}",
      date: json['release_date'] ?? json['first_air_date'] ?? '',
      rating: (json['vote_average'] as num).toDouble(),
      overview: json['overview'] ?? '',
      genres: (json['genres'] as List<dynamic>?)
          ?.map((genre) {
        if (genre is Map && genre.containsKey('name')) {
          return genre['name'] as String;
        } else if (genre is String) {
          return genre;
        } else {
          return '';
        }
      })
          .where((name) => name.isNotEmpty)
          .toList() ??
          [],
    );
  }
}
