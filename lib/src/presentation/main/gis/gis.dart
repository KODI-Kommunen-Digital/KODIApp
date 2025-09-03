import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/translate.dart';

class GIS extends StatefulWidget {
  const GIS({super.key});

  @override
  State<GIS> createState() => _GISState();
}

class _GISState extends State<GIS> {
  InAppWebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
  }

  @override
  Widget build(BuildContext context) {
    final translate = Translate.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (_controller != null && await _controller!.canGoBack()) {
          _controller!.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(translate.translate("gis")),
        ),
        body: SafeArea(
          child:InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri("https://iwebgis.net/ladbergen/buergergis/?lon=7.739632170597163&lat=52.13664495400431&zoom=18&select=false"),
            ),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              geolocationEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            androidOnGeolocationPermissionsShowPrompt: (controller, origin) async {
              return GeolocationPermissionShowPromptResponse(
                origin: origin,
                allow: true,
                retain: true,
              );
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT,
              );
            },
          )

        ),
      ),
    );
  }
}
