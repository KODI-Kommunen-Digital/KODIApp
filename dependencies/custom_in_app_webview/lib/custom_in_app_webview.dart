import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// TODO: Custom webview doesn't support geolocation handling. Need to implement it when integrating suc services.
class CustomInAppWebView extends StatefulWidget {
  final String url;
  final String? title;

  const CustomInAppWebView({super.key, required this.url, this.title});

  @override
  State<CustomInAppWebView> createState() => _CustomInAppWebViewState();

  static void showAsBottomSheet({
    required BuildContext context,
    required String url,
    String? title,
  }) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              // padding: const EdgeInsets.only(top: kToolbarHeight),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: CustomInAppWebView(url: url, title: title??url),
            ),
          ],
        );
      },
    );
  }
}

class _CustomInAppWebViewState extends State<CustomInAppWebView> {
  bool isLoading = true;
  Timer? _timer;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(),
    ),
  };

  final mangelmelderHtml = """
        <!DOCTYPE html>
        <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <script defer src="https://www.meldooplus.de/webV3/js/bundle.min.js"></script>
        </head>
        <body style="margin:0;padding:0;">
          <div id="webReportsContainer" data-key="rottenburg"></div>
        </body>
        </html>
        """;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final loaderColor = theme.colorScheme.primary;
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

    return SafeArea(
      top: false,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(0, 32, 16, 0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (await webViewController.canGoBack()) {
                        webViewController.goBack();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                // Expanded(
                //   child: Text(
                //     widget.url,
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 1,
                //     style: const TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height:
            MediaQuery.of(context).size.height - kToolbarHeight - 30,
            child: WebViewWidget(
              controller: webViewController,
              gestureRecognizers: gestureRecognizers,
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrlExternally(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      // ignore: empty_catches
    } catch (e) {}
  }

  void _startProgressTimer() {
    _timer = Timer(const Duration(seconds: 5), () {
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
