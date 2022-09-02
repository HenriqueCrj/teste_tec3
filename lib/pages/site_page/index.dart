import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:teste_tec3/widgets/custom_appbar.dart';

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
        backgroundColor: Colors.grey[700],
        appBar: CustomAppBar(
          siteButtonBorderColor: Colors.white,
          onAvatarPressed: () =>
              Navigator.of(context).pushReplacementNamed("/avatar_page"),
          onSitePressed: () => Navigator.of(context).pop(),
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
