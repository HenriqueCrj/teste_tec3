import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:teste_tec3/database/database.dart';

import 'package:teste_tec3/models/favorite.dart';
import 'package:teste_tec3/repository/favorite_repository.dart';

class HomePageController {
  final databaseHelper = GetIt.instance.get<DatabaseHelper>();
  final favoriteRepository = GetIt.instance.get<FavoriteRepository>();
  List<String> charactersNames = [];
  List<String> filmsTitles = [];
  ValueNotifier<List<Favorite>> favorites = ValueNotifier([]);

  Future<void> getAllData() async {
    await getFavorites();
    await getPeople();
    await getFilms();
  }

  Future<void> getFavorites() async {
    favorites.value = await favoriteRepository.getFavorites();
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

  void updateFavorites(Favorite favorite) async {
    var tempFavorites = favorites.value;

    if (favorites.value.contains(favorite)) {
      tempFavorites.remove(favorite);
      favoriteRepository.deleteFavoriteFromDb(favorite);
    } else {
      tempFavorites.add(favorite);
      favoriteRepository.saveFavoriteFromDb(favorite);
    }
    favorites.value = List.from(tempFavorites);
  }
}
