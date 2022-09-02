import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_tec3/database/database.dart';
import 'package:teste_tec3/models/swinfo.dart';

// Classe para executar operações de IO referentes às informações sobre Star Wars
class SWInfoRepository {
  final databaseHelper = GetIt.instance.get<DatabaseHelper>();

  // Obtém todas informações do banco de dados
  Future<List<SWInfo>> getSWInfo() async {
    Database db = await databaseHelper.getDb();

    var rows = await db.rawQuery("SELECT title, category FROM favorites;");
    return rows.map((row) => SWInfo.fromMap(row)).toList();
  }

  // Salva uma informação no banco de dados
  Future<void> saveSWInfoToDb(SWInfo info) async {
    Database db = await databaseHelper.getDb();

    var maps = await db.query(
      "favorites",
      columns: ["title", "category"],
      where: "title = ?",
      whereArgs: [info.title],
    );

    // Se o resultado estiver vazio, a informação não está lá e pode ser salva
    if (maps.isEmpty) {
      await db.rawInsert(
        "INSERT INTO favorites (title, category) VALUES (?, ?);",
        [
          info.title,
          info.category,
        ],
      );
    }
  }

  // Deleta uma informação no banco de dados
  Future<void> deleteSWInfoFromDb(SWInfo info) async {
    Database db = await databaseHelper.getDb();

    await db.delete(
      "favorites",
      where: "title = ?",
      whereArgs: [info.title],
    );
  }
}
