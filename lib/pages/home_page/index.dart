import 'package:flutter/material.dart';
import 'package:teste_tec3/models/favorite.dart';
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
  late final Future? itemsLoaded;
  final homePageController = HomePageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    itemsLoaded = homePageController.getAllData();
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
              child: FutureBuilder(
                future: itemsLoaded,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ValueListenableBuilder<List<Favorite>>(
                        valueListenable: homePageController.favorites,
                        builder: (context, favorites, child) {
                          return TabBarView(
                            controller: _tabController,
                            children: [
                              ListView.builder(
                                itemCount:
                                    homePageController.filmsTitles.length,
                                itemBuilder: (context, index) {
                                  var data = Favorite(
                                    homePageController.filmsTitles[index],
                                    "film",
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListItem(
                                      initialFavoriteState:
                                          favorites.contains(data),
                                      text: data.title,
                                      category: "film",
                                      onPressed: (favorite) {
                                        homePageController
                                            .updateFavorites(favorite);
                                      },
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount:
                                    homePageController.charactersNames.length,
                                itemBuilder: (context, index) {
                                  var data = Favorite(
                                    homePageController.charactersNames[index],
                                    "person",
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListItem(
                                      initialFavoriteState:
                                          favorites.contains(data),
                                      text: data.title,
                                      category: "person",
                                      onPressed: (favorite) {
                                        homePageController
                                            .updateFavorites(favorite);
                                      },
                                    ),
                                  );
                                },
                              ),
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
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
