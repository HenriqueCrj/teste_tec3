import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:teste_tec3/database/database.dart';

import 'package:teste_tec3/models/favorite.dart';

class HomePageController {
  List<String> charactersNames = [];
  List<String> filmsTitles = [];
  ValueNotifier<List<Favorite>> favorites = ValueNotifier([]);
  final databaseHelper = GetIt.instance.get<DatabaseHelper>();

  Future<void> getAllData() async {
    await getFavorites();
    await getPeople();
    await getFilms();
  }

  Future<void> getFavorites() async {
    Database db = await databaseHelper.getDb();
    var rows = await db.rawQuery("SELECT title, category FROM favorites;");
    favorites.value = rows.map((row) => Favorite.fromMap(row)).toList();
  }

  Future<void> getPeople() async {
    var url = Uri.parse("https://swapi.dev/api/people/");
    var response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      List<dynamic> results = convert
          .jsonDecode(convert.utf8.decode(response.bodyBytes))["results"];
      charactersNames =
          results.map((person) => person["name"] as String).toList();
    }
  }

  Future<void> getFilms() async {
    var url = Uri.parse("https://swapi.dev/api/films/");
    var response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      List<dynamic> results = convert
          .jsonDecode(convert.utf8.decode(response.bodyBytes))["results"];
      filmsTitles = results.map((film) => film["title"] as String).toList();
    }
  }

  void saveFavoriteFromDb(Favorite favorite) async {
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

  void deleteFavoriteFromDb(Favorite favorite) async {
    Database db = await databaseHelper.getDb();

    await db.delete(
      "favorites",
      where: "title = ?",
      whereArgs: [favorite.title],
    );
  }

  void switchFavoriteForTitle(Favorite favorite) {
    var tempFavorites = favorites.value;

    if (favorites.value.contains(favorite)) {
      tempFavorites.remove(favorite);
      deleteFavoriteFromDb(favorite);
    } else {
      tempFavorites.add(favorite);
      saveFavoriteFromDb(favorite);
    }
    favorites.value = List.from(tempFavorites);
  }
}
