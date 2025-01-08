// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobilitatHelper {
  static final Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers =
      {Factory(() => EagerGestureRecognizer())};

  static Future<void> showMobilitat(BuildContext context) async {
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("https://go.ridedott.com/vehicles/")) {
              _lauchUrlExternally(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://troisdorf.dksr.city/map/"));

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(5, 32, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'smartAPP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            48), // Placeholder to balance the space taken by the IconButton
                  ],
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 30,
                child: WebViewWidget(
                  controller: webViewController,
                  gestureRecognizers: _gestureRecognizers,
                ),
              ),
            ],
          ),
        );
      },
    );

    await webViewController.runJavaScript(
        "document.querySelector('.flex').style.display = 'none';");
  }

  static Future<void> _lauchUrlExternally(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<NavigationActionPolicy> getUrlLoading(
      NavigationAction navigationAction) async {
    final url = navigationAction.request.url?.toString() ?? "";

    if (url.startsWith("https://go.ridedott.com/vehicles/")) {
      await _lauchUrlExternally(url);
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }
}
