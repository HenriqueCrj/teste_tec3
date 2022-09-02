import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:teste_tec3/database/database.dart';
import 'package:teste_tec3/models/swinfo.dart';
import 'package:teste_tec3/repository/swinfo_repository.dart';

class HomePageController {
  final databaseHelper = GetIt.instance.get<DatabaseHelper>();
  final swinfoRepository = GetIt.instance.get<SWInfoRepository>();

  List<SWInfo> people = [];
  List<SWInfo> films = [];
  ValueNotifier<List<SWInfo>> favorites = ValueNotifier([]);

  void getFavorites() async {
    favorites.value = await swinfoRepository.getSWInfo();
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
      people = results
          .map((person) => SWInfo(person["name"] as String, "person"))
          .toList();
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
      films = results
          .map((film) => SWInfo(film["title"] as String, "film"))
          .toList();
    }
  }

  void updateFavorites(SWInfo info) async {
    var tempFavorites = favorites.value;

    if (favorites.value.contains(info)) {
      tempFavorites.remove(info);
      swinfoRepository.deleteSWInfoFromDb(info);
    } else {
      tempFavorites.add(info);
      swinfoRepository.saveSWInfoToDb(info);
    }
    favorites.value = List.from(tempFavorites);
  }
}
