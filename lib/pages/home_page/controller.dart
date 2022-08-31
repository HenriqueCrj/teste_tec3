import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomePageController {
  List<String> charactersNames = [];
  List<String> filmsTitles = [];
  ValueNotifier<List<String>> favorites = ValueNotifier([]);

  Future<void> getAllData() async {
    await getPeople();
    await getFilms();
    await getFavorites();
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
      print(charactersNames);
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
      print(filmsTitles);
    }
  }

  Future<void> getFavorites() async {}
}
