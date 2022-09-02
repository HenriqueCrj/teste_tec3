import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SitePage extends StatefulWidget {
  const SitePage({super.key});

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  // Permite a atualização da página com o deslize vertical
  late PullToRefreshController pullToRefreshController;
  final starWarsUrl = "https://www.starwars.com/community";

  InAppWebViewGroupOptions initialOptions = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      // Controla se as mídios serão autoativadas (vídeos e sons)
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      // true to use pull to refresh
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.yellow,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(
              url: await webViewController?.getUrl(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[900],
          title: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
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
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed("/avatar_page"),
                icon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
        // WebView para exibir o site da comunidade de Star Wars
        body: InAppWebView(
          key: webViewKey,
          // A url
          initialUrlRequest: URLRequest(
            url: Uri.parse(starWarsUrl),
          ),
          initialOptions: initialOptions,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT,
            );
          },
          onLoadError: (controller, url, code, message) {
            pullToRefreshController.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController.endRefreshing();
            }
          },
        ),
      ),
    );
  }
}
