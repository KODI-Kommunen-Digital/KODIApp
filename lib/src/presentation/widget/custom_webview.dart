import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heidi/src/utils/mobilitat_helper.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
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

      final bool hasPermission = await requestGeoPermission();

      // Close the loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                Translate.of(context).translate('geo_permission_needed'))));
        return;
      }
    }
    // Opened as an opaque full-screen page on the root navigator so nothing
    // behind it (including any bottom navigation) stays visible. As a
    // fullscreen dialog it slides up and has no iOS swipe-to-dismiss, which
    // would fight with the web page gestures; it is closed via its buttons
    // or the system back once the history is exhausted.
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) => CustomWebViewScreen(
          url: url,
          title: title,
          hasGeoLocation: needGeoLocation,
        ),
      ),
    );
  }
}

Future<bool> requestGeoPermission() async {
  bool permissionGranted = false;
  bool openSettings = true;
  bool exit = false;

  while (!permissionGranted) {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {
        //await Geolocator.getCurrentPosition(
        //    desiredAccuracy: LocationAccuracy.high);
        permissionGranted = true;
      } catch (e) {
        logError('Error getting current position: $e');
      }
    } else if ((permission == LocationPermission.unableToDetermine ||
            permission == LocationPermission.denied) &&
        openSettings == true) {
      await Geolocator.requestPermission();
      openSettings = false;
    } else {
      if (exit == false) {
        await openAppSettings();
        exit = true;
      } else {
        return false;
      }
    }
  }
  return permissionGranted;
}

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  // Schemes the web view can render itself. Anything else (mailto:, tel:,
  // sms:, whatsapp:, intent:, ...) is handed over to the OS.
  static const Set<String> _webSchemes = {
    'http',
    'https',
    'about',
    'data',
    'blob',
    'javascript',
    'file',
  };

  InAppWebViewController? webViewController;
  PullToRefreshController? _pullToRefreshController;
  bool _isInitialLoading = true;
  double _progress = 0;
  String? _pageTitle;
  WebUri? _currentUrl;

  // Let the web view claim every gesture so long-press text selection, the
  // selection handles and horizontal scrolling are not stolen by the route.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pull-to-refresh is left out on geolocation pages (maps), where dragging
    // the map down would otherwise trigger a reload.
    if (!widget.hasGeoLocation && _pullToRefreshController == null) {
      _pullToRefreshController = PullToRefreshController(
        settings: PullToRefreshSettings(
          color: Theme.of(context).colorScheme.primary,
        ),
        onRefresh: () async {
          final controller = webViewController;
          if (controller == null) {
            _pullToRefreshController?.endRefreshing();
            return;
          }
          if (Platform.isAndroid) {
            await controller.reload();
          } else {
            await controller.loadUrl(
                urlRequest: URLRequest(url: await controller.getUrl()));
          }
        },
      );
    }
  }

  void _endRefreshing() {
    _pullToRefreshController?.endRefreshing();
  }

  /// Shares the page currently shown in the browser.
  Future<void> _shareCurrentPage(BuildContext buttonContext) async {
    final url = (await webViewController?.getUrl())?.toString() ??
        _currentUrl?.toString() ??
        widget.url;
    final title = _pageTitle ?? widget.title;

    // iPad needs an anchor for the share popover.
    final box = buttonContext.findRenderObject() as RenderBox?;
    final origin =
        box != null ? box.localToGlobal(Offset.zero) & box.size : null;

    try {
      await SharePlus.instance.share(ShareParams(
        text: title != null ? '$title\n$url' : url,
        subject: title,
        sharePositionOrigin: origin,
      ));
    } catch (e) {
      logError('Could not share $url: $e');
    }
  }

  /// Walks back through the web view history and closes the browser once the
  /// originally opened page is reached.
  Future<void> _handleBack() async {
    final controller = webViewController;
    if (controller != null && await controller.canGoBack()) {
      await controller.goBack();
      return;
    }
    _close();
  }

  void _close() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final loaderColor = theme.colorScheme.primary;
    final materialLocalizations = MaterialLocalizations.of(context);
    final displayedUri = _currentUrl ?? Uri.tryParse(widget.url);
    final host = displayedUri?.host ?? '';
    final isSecure = displayedUri?.scheme == 'https';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            tooltip: materialLocalizations.backButtonTooltip,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: _handleBack,
          ),
          titleSpacing: 0,
          centerTitle: false,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title ?? _pageTitle ?? widget.url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (host.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      Icon(
                        isSecure
                            ? Icons.lock_outline_rounded
                            : Icons.info_outline_rounded,
                        size: 12,
                        color: theme.hintColor,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          host,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            Builder(
              builder: (buttonContext) => IconButton(
                tooltip: Translate.of(context).translate('share'),
                icon: Icon(Platform.isIOS
                    ? Icons.ios_share_rounded
                    : Icons.share_outlined),
                onPressed: () => _shareCurrentPage(buttonContext),
              ),
            ),
            IconButton(
              tooltip: materialLocalizations.closeButtonTooltip,
              icon: const Icon(Icons.close_rounded),
              onPressed: _close,
            ),
            const SizedBox(width: 4),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2),
            child: _progress < 1
                ? LinearProgressIndicator(
                    value: _progress > 0 ? _progress : null,
                    minHeight: 2,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
                  )
                : Divider(height: 2, thickness: 1, color: theme.dividerColor),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest:
                  URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
              gestureRecognizers: gestureRecognizers,
              pullToRefreshController: _pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  _currentUrl = url;
                  _progress = 0;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                  if (progress >= 100) {
                    _isInitialLoading = false;
                  }
                });
                if (progress >= 100) {
                  _endRefreshing();
                }
              },
              onPageCommitVisible: (controller, url) {
                if (_isInitialLoading) {
                  setState(() {
                    _isInitialLoading = false;
                  });
                }
              },
              onTitleChanged: (controller, title) {
                setState(() {
                  _pageTitle =
                      (title == null || title.trim().isEmpty) ? null : title;
                });
              },
              onUpdateVisitedHistory: (controller, url, isReload) {
                setState(() {
                  _currentUrl = url;
                });
              },
              onLoadStop: (controller, url) async {
                if (Platform.isIOS) {
                  await controller.evaluateJavascript(source: """
                  var metaTags = document.querySelectorAll('meta[http-equiv="Content-Security-Policy"]');
                  metaTags.forEach(function(tag) { tag.parentNode.removeChild(tag); });
                """);
                }

                _endRefreshing();
                if (!mounted) return;
                setState(() {
                  _currentUrl = url;
                  _progress = 1;
                  _isInitialLoading = false;
                });

                // // Hide elements with the "flex" class - Commenting it since Daniel don't remember why it was added
                // await controller.evaluateJavascript(
                //   source:
                //       "document.querySelector('.flex').style.display = 'none';",
                // );
              },
              onReceivedError: (controller, request, error) {
                if (request.isForMainFrame ?? true) {
                  _endRefreshing();
                  setState(() {
                    _progress = 1;
                    _isInitialLoading = false;
                  });
                }
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
                  useShouldOverrideUrlLoading: true,
                  disableContextMenu: false,
                  // iOS edge swipe goes back in the page history
                  allowsBackForwardNavigationGestures: true,
                  allowsLinkPreview: false,
                  userAgent:
                      "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36"),
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              onGeolocationPermissionsShowPrompt: (widget.hasGeoLocation)
                  ? (InAppWebViewController controller, String origin) async {
                      return GeolocationPermissionShowPromptResponse(
                          origin: origin, allow: true, retain: true);
                    }
                  : null,
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url;
                if (uri != null &&
                    uri.scheme.isNotEmpty &&
                    !_webSchemes.contains(uri.scheme.toLowerCase())) {
                  await _openInExternalApp(uri.toString());
                  return NavigationActionPolicy.CANCEL;
                }

                if (widget.hasGeoLocation) {
                  return MobilitatHelper.getUrlLoading(navigationAction);
                } else {
                  final url = uri.toString();

                  if (url.startsWith("https://go.ridedott.com/vehicles/")) {
                    _launchUrlExternally(url);
                    return NavigationActionPolicy
                        .CANCEL; // Prevent navigation inside WebView
                  }
                  return NavigationActionPolicy.ALLOW;
                }
              },
            ),

            // Loading indicator overlay, only until the first page shows up
            if (_isInitialLoading)
              Positioned.fill(
                child: Container(
                  color: backgroundColor,
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

  /// Opens mailto:, tel:, sms:, app deep links and Android intent:// links in
  /// the matching app instead of the web view.
  Future<void> _openInExternalApp(String url) async {
    if (url.startsWith('intent://')) {
      await _openIntentUrl(url);
      return;
    }

    final uri = Uri.tryParse(url);
    final launched = uri != null && await _tryLaunch(uri);
    if (!launched) {
      _showNoAppFound();
    }
  }

  /// Handles intent://host/path#Intent;scheme=xyz;S.browser_fallback_url=...;end
  Future<void> _openIntentUrl(String url) async {
    const intentPrefix = 'intent://';
    const intentMarker = '#Intent;';
    final markerIndex = url.indexOf(intentMarker);
    final params = <String, String>{};
    if (markerIndex != -1) {
      for (final part
          in url.substring(markerIndex + intentMarker.length).split(';')) {
        final separator = part.indexOf('=');
        if (separator > 0) {
          params[part.substring(0, separator)] = part.substring(separator + 1);
        }
      }
    }

    final scheme = params['scheme'];
    if (scheme != null) {
      final target = Uri.tryParse(
          '$scheme://${url.substring(intentPrefix.length, markerIndex)}');
      if (target != null && await _tryLaunch(target)) return;
    }

    final fallback = params['S.browser_fallback_url'];
    if (fallback != null) {
      await webViewController?.loadUrl(
          urlRequest: URLRequest(url: WebUri(Uri.decodeComponent(fallback))));
      return;
    }

    _showNoAppFound();
  }

  Future<bool> _tryLaunch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      logError('Could not launch $uri: $e');
      return false;
    }
  }

  void _showNoAppFound() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('no_app_to_open_link'))));
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
}
