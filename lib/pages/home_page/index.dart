import 'package:flutter/material.dart';
import 'package:teste_tec3/models/swinfo.dart';
import 'package:teste_tec3/pages/home_page/controller.dart';

import 'package:teste_tec3/widgets/custom_appbar.dart';
import 'widgets/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  Future? _filmsLoaded;
  Future? _peopleLoaded;
  final _homePageController = HomePageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _homePageController.getFavorites();
    _filmsLoaded = _homePageController.getFilms();
    _peopleLoaded = _homePageController.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: CustomAppBar(
          onAvatarPressed: () =>
              Navigator.of(context).pushNamed("/avatar_page"),
          onSitePressed: () => Navigator.of(context).pushNamed("/site_page"),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey[800],
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(),
                ),
                tabs: const [
                  Tab(text: "Filmes"),
                  Tab(text: "Personagens"),
                  Tab(text: "Favoritos"),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<SWInfo>>(
                valueListenable: _homePageController.favorites,
                builder: (context, favorites, child) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      FutureBuilder<void>(
                        future: _filmsLoaded,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Lista de filmes
                            return ListView.builder(
                              itemCount: _homePageController.films.length,
                              itemBuilder: (context, index) {
                                var swinfo = _homePageController.films[index];
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListItem(
                                    initialFavoriteState:
                                        favorites.contains(swinfo),
                                    swinfo: swinfo,
                                    onPressed: (swinfo) {
                                      _homePageController
                                          .updateFavorites(swinfo);
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                      FutureBuilder<void>(
                        future: _peopleLoaded,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Lista de pessoas
                            return ListView.builder(
                              itemCount: _homePageController.people.length,
                              itemBuilder: (context, index) {
                                var swinfo = _homePageController.people[index];
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListItem(
                                    initialFavoriteState:
                                        favorites.contains(swinfo),
                                    swinfo: swinfo,
                                    onPressed: (swinfo) {
                                      _homePageController
                                          .updateFavorites(swinfo);
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                      // Lista de favoritos
                      ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          var favorite = favorites[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: favorite.category == "film"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                favorite.title,
                                style: const TextStyle(
                                  fontFamily: "Conthrax",
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
