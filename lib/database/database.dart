import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Uma interface para criar diferentes implementações caso seja necessário
abstract class DatabaseHelper {
  Future initialize();
  Future<Database> getDb();
}

// Implementação em SQLite
class SQLiteDatabaseHelper implements DatabaseHelper {
  final String path = "appdata.db";
  final String favoritesTable = "favorites";
  final String avatarTable = "avatar";
  late Future<Database> _db;

  @override
  Future<Database> getDb() {
    // Inicia o banco de dados se já não estiver inicializado
    _db = initialize();
    return _db;
  }

  @override
  Future<Database> initialize() async {
    var databasesPath = await getDatabasesPath();
    // Apenas uma instância do banco de dados será retornada por chamada de openDatabase
    // por conta do parâmetro singleInstance = true
    return await openDatabase(
      join(databasesPath, path),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
          CREATE TABLE IF NOT EXISTS $favoritesTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT UNIQUE NOT NULL,
            category TEXT NOT NULL
          );
          """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS $avatarTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fluttermoji TEXT NOT NULL
          );
          """);
      },
    );
  }
}
