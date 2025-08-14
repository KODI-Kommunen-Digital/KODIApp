import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:heidi/src/utils/translate.dart';
// import 'package:loggy/loggy.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomWebViewScreen extends StatefulWidget {
  final String url;
  final String? title;
  final bool hasGeoLocation;

  const CustomWebViewScreen(
      {super.key, required this.url, this.title, this.hasGeoLocation = false});

  @override
  State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();

  static void showAsBottomSheet(
      {required BuildContext context,
      required String url,
      String? title,
      bool needGeoLocation = false}) async {
    if (needGeoLocation) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // final bool hasPermission = await requestGeoPermission();

      // Close the loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      // if (!hasPermission) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text(
      //           Translate.of(context).translate('geo_permission_needed'))));
      //   return;
      // }
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: kToolbarHeight),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: CustomWebViewScreen(
                url: url,
                title: title,
                hasGeoLocation: needGeoLocation,
              ),
            ),
          ],
        );
      },
    );
  }
}

// Future<bool> requestGeoPermission() async {
//   bool permissionGranted = false;
//   bool openSettings = true;
//   bool exit = false;

//   while (!permissionGranted) {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       try {
//         //await Geolocator.getCurrentPosition(
//         //    desiredAccuracy: LocationAccuracy.high);
//         permissionGranted = true;
//       } catch (e) {
//         logError('Error getting current position: $e');
//       }
//     } else if ((permission == LocationPermission.unableToDetermine ||
//             permission == LocationPermission.denied) &&
//         openSettings == true) {
//       await Geolocator.requestPermission();
//       openSettings = false;
//     } else {
//       if (exit == false) {
//         await openAppSettings();
//         exit = true;
//       } else {
//         return false;
//       }
//     }
//   }
//   return permissionGranted;
// }

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  InAppWebViewController? webViewController;
  bool isLoading = true;
  Timer? _timer;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(),
    ),
  };

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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, object) async {
        if (didPop) return;

        if (webViewController != null && await webViewController!.canGoBack()) {
          webViewController!.goBack();
        } else {
          if (mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
          title: Text(
            (widget.title ?? widget.url.toString()),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
                gestureRecognizers: gestureRecognizers,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    isLoading = true;
                  });
                  _startProgressTimer();
                },
                onLoadStop: (controller, url) async {
                  if (Platform.isIOS) {
                    await controller.evaluateJavascript(source: """
                  var metaTags = document.querySelectorAll('meta[http-equiv="Content-Security-Policy"]');
                  metaTags.forEach(function(tag) { tag.parentNode.removeChild(tag); });
                """);
                  }

                  _timer?.cancel;
                  _timer = null;
                  setState(() {
                    isLoading = false;
                  });

                  // // Hide elements with the "flex" class - Commenting it since Daniel don't remember why it was added
                  // await controller.evaluateJavascript(
                  //   source:
                  //       "document.querySelector('.flex').style.display = 'none';",
                  // );
                },
                onPermissionRequest: (widget.hasGeoLocation)
                    ? (InAppWebViewController controller,
                        PermissionRequest request) async {
                        return PermissionResponse(
                          resources: request.resources,
                          action: PermissionResponseAction.GRANT,
                        );
                      }
                    : null,
                initialSettings: InAppWebViewSettings(
                    useWideViewPort: (widget.hasGeoLocation) ? true : null,
                    geolocationEnabled: (widget.hasGeoLocation) ? true : null,
                    javaScriptEnabled: true,
                    domStorageEnabled: true,
                    allowsInlineMediaPlayback: true,
                    mediaPlaybackRequiresUserGesture: false,
                    iframeAllow: "camera; microphone",
                    userAgent:
                        "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36"),
                onReceivedServerTrustAuthRequest: (controller, challenge) async {
                  return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED);
                },
                // onGeolocationPermissionsShowPrompt: (widget.hasGeoLocation)
                //     ? (InAppWebViewController controller, String origin) async {
                //         return GeolocationPermissionShowPromptResponse(
                //             origin: origin, allow: true, retain: true);
                //       }
                //     : null,
                // shouldOverrideUrlLoading: (controller, navigationAction) async {
                //   if (widget.hasGeoLocation) {
                //     return MobilitatHelper.getUrlLoading(navigationAction);
                //   } else {
                //     final url = navigationAction.request.url.toString();

                //     if (url.startsWith("https://go.ridedott.com/vehicles/")) {
                //       _launchUrlExternally(url);
                //       return NavigationActionPolicy
                //           .CANCEL; // Prevent navigation inside WebView
                //     }
                //     return NavigationActionPolicy.ALLOW;
                //   }
                // },
              ),
            ),

            // Loading indicator overlay
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: backgroundColor
                      .withAlpha((0.8 * 255).toInt()), // Matches theme
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _launchUrlExternally(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  void _startProgressTimer() {
    _timer = Timer(const Duration(seconds: 1), () {
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
