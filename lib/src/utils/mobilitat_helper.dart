// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';
import 'package:url_launcher/url_launcher.dart';

class MobilitatHelper {

  static Future<void> showMobilitat(BuildContext context) async {

     CustomWebViewScreen.showAsBottomSheet(context: context, url: "https://troisdorf.dksr.city/map/", title: 'Mobilitätskarte');
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
