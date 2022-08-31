import 'package:flutter/material.dart';
import 'package:teste_tec3/pages/home_page/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final homePageController = HomePageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {},
            child: const Text("Site oficial"),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
              ),
            ),
          ],
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
                  Tab(
                    text: "Filmes",
                  ),
                  Tab(
                    text: "Personagens",
                  ),
                  Tab(
                    text: "Favoritos",
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: homePageController.getAllData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          itemCount: homePageController.filmsTitles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title:
                                  Text(homePageController.filmsTitles[index]),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: homePageController.charactersNames.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  homePageController.charactersNames[index]),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("$index"),
                            );
                          },
                        ),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
