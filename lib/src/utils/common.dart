import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:heidi/src/data/model/model_device.dart';
import 'package:location/location.dart';

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
