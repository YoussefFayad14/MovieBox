import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT,
        overview TEXT,
        date TEXT,
        rating REAL,
        genres TEXT
      )
    ''');
  }

  // Insert a movie
  Future<int> insertFavorite(Map<String, dynamic> movie) async {
    final db = await database;
    return await db.insert('favorites', movie, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all favorites
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }

  // Delete a favorite
  Future<int> deleteFavorite(int id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  // Check if a movie is favorite
  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
