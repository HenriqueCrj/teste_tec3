import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:teste_tec3/models/favorite.dart';

class HomePageController {
  List<String> charactersNames = [];
  List<String> filmsTitles = [];
  ValueNotifier<List<Favorite>> favorites = ValueNotifier([]);

  Future<void> getAllData() async {
    await getFavorites();
    await getPeople();
    await getFilms();
  }

  Future<void> getFavorites() async {}

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

  void switchFavoriteForTitle(Favorite favorite) {
    var tempFavorites = favorites.value;

    if (favorites.value.contains(favorite)) {
      tempFavorites.remove(favorite);
    } else {
      tempFavorites.add(favorite);
    }
    favorites.value = List.from(tempFavorites);
  }
}
