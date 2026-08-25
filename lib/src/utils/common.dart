import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:heidi/src/data/model/model_device.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  Future<File> loadCachedPdf(String url) async {
    return await DefaultCacheManager().getSingleFile(url);
  }

  static Widget showCachedPdf(String url) {
    return _CachedPdfViewer(key: ValueKey(url), url: url);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  ///Returns true when [url] uses a scheme our in-app WebView can render
  ///directly. Pages can redirect to app-deep-link schemes it can't (e.g.
  ///Instagram's `intent://...#Intent;...;end`), which otherwise fail with
  ///net::ERR_UNKNOWN_URL_SCHEME.
  static bool isWebNavigable(String url) {
    final scheme = Uri.tryParse(url)?.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https';
  }

  ///Hands a non-http(s) link (app deep link / intent URL) to the OS instead
  ///of letting the WebView try to render it. Opens the target app if it's
  ///installed; falls back to the browser otherwise.
  static Future<void> launchExternalAppLink(String url) async {
    String targetUrl = url;
    if (Uri.tryParse(url)?.scheme.toLowerCase() == 'intent') {
      targetUrl = _resolveIntentUri(url) ?? url;
    }
    try {
      await launchUrl(
          Uri.parse(targetUrl), mode: LaunchMode.externalApplication);
    } catch (_) {
      // Not launchable (app not installed, malformed link, etc.) - ignore.
    }
  }

  ///Android's `intent://` scheme (used by Instagram/Facebook/etc. to deep-link
  ///into their app from a webpage) isn't a real launchable URI on its own -
  ///`url_launcher` just does `Uri.parse` + `ACTION_VIEW`, which throws
  ///`ActivityNotFoundException` for a bare `intent:` scheme since no app
  ///registers a handler for it. Unwrap it into the URL the intent actually
  ///targets: its `S.browser_fallback_url` extra if present, otherwise the
  ///`https://<host><path>?<query>` App Link reconstructed from the intent's
  ///own authority/path/query plus its `scheme=` extra. Instagram/Facebook
  ///register as verified App Link handlers for their domains, so launching
  ///that URL externally opens their app directly when installed and falls
  ///back to the browser otherwise.
  static String? _resolveIntentUri(String intentUrl) {
    final hashIndex = intentUrl.indexOf('#Intent;');
    if (hashIndex == -1) return null;
    final prefix = intentUrl.substring(0, hashIndex);
    final intentPart = intentUrl.substring(hashIndex + '#Intent;'.length);

    final fallbackMatch =
        RegExp(r'S\.browser_fallback_url=([^;]+)').firstMatch(intentPart);
    if (fallbackMatch != null) {
      return Uri.decodeComponent(fallbackMatch.group(1)!);
    }

    final schemeMatch = RegExp(r'(?:^|;)scheme=([^;]+)').firstMatch(intentPart);
    final scheme = schemeMatch?.group(1) ?? 'https';
    return prefix.replaceFirst(RegExp(r'^intent://'), '$scheme://');
  }

  static Future<DeviceModel?> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final android = await deviceInfoPlugin.androidInfo;
        return DeviceModel(
          uuid: android.id,
          model: "Android",
          version: android.version.sdkInt.toString(),
          type: android.model,
        );
      } else if (Platform.isIOS) {
        final IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
        return DeviceModel(
          uuid: ios.identifierForVendor??"",
          name: ios.name,
          model: ios.systemName,
          version: ios.systemVersion,
          type: ios.utsname.machine,
        );
      }
    } catch (e) {
      // UtilLogger.log("ERROR", e);
    }
    return null;
  }

  static Future<LocationData?> getLocation() async {
    Location location = Location();
    PermissionStatus permissionGranted;
    LocationData? locationData;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return locationData;
      }
    }

    return await location.getLocation();
  }

  ///Singleton factory
  static final Utils _instance = Utils._internal();

  factory Utils() {
    return _instance;
  }

  Utils._internal();
}

///Fetches and caches the PDF file once per [url] so ancestor rebuilds don't
///restart the download/render or reset the viewer's zoom and scroll state.
class _CachedPdfViewer extends StatefulWidget {
  const _CachedPdfViewer({super.key, required this.url});

  final String url;

  @override
  State<_CachedPdfViewer> createState() => _CachedPdfViewerState();
}

class _CachedPdfViewerState extends State<_CachedPdfViewer> {
  late Future<File> _fileFuture;
  String? _renderError;

  @override
  void initState() {
    super.initState();
    _fileFuture = DefaultCacheManager().getSingleFile(widget.url);
  }

  @override
  void didUpdateWidget(covariant _CachedPdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _renderError = null;
      _fileFuture = DefaultCacheManager().getSingleFile(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _fileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (_renderError != null) {
          return Center(child: Text(_renderError!));
        }

        ///[PDFView] embeds the platform's native PDF renderer (PDFKit on iOS,
        ///AndroidPdfViewer on Android) so pinch-zoom/pan is handled entirely
        ///by the OS instead of Flutter re-rasterizing page tiles, which is
        ///what caused the flicker/jump with the previous canvas-based viewer.
        return PDFView(
          filePath: snapshot.data!.path,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: false,
          pageSnap: false,
          fitPolicy: FitPolicy.BOTH,
          onError: (error) {
            setState(() {
              _renderError = error.toString();
            });
          },
          onPageError: (page, error) {
            setState(() {
              _renderError = error.toString();
            });
          },
        );
      },
    );
  }
}
