import 'package:flutter/material.dart';

import 'pages/avatar_page/index.dart';
import 'pages/home_page/index.dart';
import 'pages/site_page/index.dart';

void main() {
  runApp(const SWApp());
}

class SWApp extends StatelessWidget {
  const SWApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wars App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/avatar_page": (context) => const AvatarPage(),
        "/site_page": (context) => const SitePage(),
      },
    );
  }
}
