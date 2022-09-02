import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';

import 'pages/avatar_page/index.dart';
import 'pages/home_page/index.dart';
import 'pages/site_page/index.dart';
import 'services/service_locator.dart';

void main() async {
  // Garante que a comunicação com a engine será possível antes de rodar o app
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    // Depois tornar falso para desativar debugging de conteudos web
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    // Verifica se será possível usar Service Workers
    bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);

    bool swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        // Interceptação de recursos das requisições
        shouldInterceptRequest: (request) async {
          return null;
        },
      ));
    }
  }

  // Sou obrigado a usar GetX para esse controlador se injetado e
  // usado pelos widgets da biblioteca Fluttermoji, então baixei o GetX
  Get.lazyPut(() => FluttermojiController());

  setupGetIt();
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
