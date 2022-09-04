import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_tec3/database/database.dart';

// Classe para executar operações de IO referentes às informações sobre Star Wars
class AvatarRepository {
  final databaseHelper = GetIt.instance.get<DatabaseHelper>();
  // Já que precisei usar GetX para injetar esse controlador, usarei o mesmo para obter
  // o fluttermoji. Se não tivesse o controlador, usaria a biblioteca
  // SharedPreferences que o Fluttermoji utiliza para salvar os dados
  final fluttermojiController = Get.find<FluttermojiController>();

  // Descobri como o avatar é salvo na biblioteca ao encontrar a função
  // setFluttermoji dentro de FluttermojiController
  // A biblioteca usa SharedPreferences para salvar os dados do avatar como uma grande String
  // no formato svg
  // Então posso usar esse conhecimento para gravar no banco de dados
  Future<void> saveAvatar() async {
    Database db = await databaseHelper.getDb();
    String fluttermoji = fluttermojiController.getFluttermojiFromOptions();

    var maps = await db.query(
      "avatar",
      columns: ["fluttermoji"],
      where: "id = 1",
    );

    if (maps.isEmpty) {
      await db.rawInsert(
        "INSERT INTO avatar (id, fluttermoji) VALUES (1, ?);",
        [
          fluttermoji,
        ],
      );
    } else {
      await db.rawUpdate(
        "UPDATE avatar SET fluttermoji = ? WHERE id = 1;",
        [
          fluttermoji,
        ],
      );
    }
  }
}
