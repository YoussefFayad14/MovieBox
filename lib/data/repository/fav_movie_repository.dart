import '../local/database_helper.dart';
import '../model/movie.dart';

class FavMovieRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addToFavorites(Movie movie) async {
    final movieMap = {
      'id': movie.id,
      'title': movie.title,
      'image': movie.image,
      'overview': movie.overview,
      'date': movie.date,
      'rating': movie.rating,
      'genres': movie.genres.join(', '),
    };
    await _dbHelper.insertFavorite(movieMap);
  }

  Future<void> removeFromFavorites(int id) async {
    await _dbHelper.deleteFavorite(id);
  }

  Future<List<Movie>> getFavorites() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getFavorites();

    return maps.map((map) {
      return Movie(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        overview: map['overview'],
        date: map['date'],
        rating: map['rating'],
        genres: map['genres'].split(', '),
      );
    }).toList();
  }

  Future<bool> isFavorite(int id) async {
    return await _dbHelper.isFavorite(id);
  }
}
