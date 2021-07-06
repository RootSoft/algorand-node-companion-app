import 'dart:async';
import 'dart:io';

import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MetricsPage extends StatefulWidget {
  static String routeName = '/metrics';

  const MetricsPage({Key? key}) : super(key: key);

  @override
  _MetricsPageState createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && Platform.isAndroid)
      WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (context) {
          if (kIsWeb) {
            return _buildNotAvailable('Web');
          }

          if (Platform.isAndroid || Platform.isIOS) {
            return WebView(
              initialUrl: 'https://metrics.algorand.org/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {},
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              gestureNavigationEnabled: false,
            );
          }

          return _buildNotAvailable(Platform.operatingSystem);
        },
      ),
    );
  }

  Widget _buildNotAvailable(String platform) {
    return Center(
      child: Text(
        'Metrics not available on $platform',
        style: semiBoldTextStyle,
      ),
    );
  }
}
