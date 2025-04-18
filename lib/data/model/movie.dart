class Movie {
  final int id;
  final String title;
  final String image;
  final String date;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? '',
      image: "https://image.tmdb.org/t/p/w500${json['poster_path']}",
      date: json['release_date'] ?? json['first_air_date'] ?? '',
      rating: (json['vote_average'] as num).toDouble(),
    );
  }
}
