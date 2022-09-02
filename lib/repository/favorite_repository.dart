import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_tec3/database/database.dart';
import 'package:teste_tec3/models/favorite.dart';

class FavoriteRepository {
  final databaseHelper = GetIt.instance.get<DatabaseHelper>();

  Future<List<Favorite>> getFavorites() async {
    Database db = await databaseHelper.getDb();
    var rows = await db.rawQuery("SELECT title, category FROM favorites;");
    return rows.map((row) => Favorite.fromMap(row)).toList();
  }

  Future<void> saveFavoriteFromDb(Favorite favorite) async {
    Database db = await databaseHelper.getDb();
    // Procura pelo favorito no banco de dados
    var maps = await db.query(
      "favorites",
      columns: ["title", "category"],
      where: "title = ?",
      whereArgs: [favorite.title],
    );

    // Se o resultado estiver vazio, ele não está lá
    if (maps.isEmpty) {
      await db.rawInsert(
        "INSERT INTO favorites (title, category) VALUES (?, ?);",
        [
          favorite.title,
          favorite.category,
        ],
      );
    }
  }

  Future<void> deleteFavoriteFromDb(Favorite favorite) async {
    Database db = await databaseHelper.getDb();

    await db.delete(
      "favorites",
      where: "title = ?",
      whereArgs: [favorite.title],
    );
  }
}
