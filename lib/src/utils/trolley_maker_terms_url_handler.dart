import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class TrolleyMakerTermsUrlHandler {
    static String _getBaseUrl() {
    return dotenv.env['TROLLEY_MAKER_WEB_BASE_URL']!;
  }
  static launchConditionsUrl() {
    var url = "${_getBaseUrl()}conditions-of-participation";
    launchWebUrl(url);
  }

  static launchConsentDeclerationUrl() {
    var url = "${_getBaseUrl()}declaration-of-consent";
    launchWebUrl(url);
  }

  static launchPrivacyPolicyUrl() {
    var url = "${_getBaseUrl()}privacy-policy";
    launchWebUrl(url);
  }

  static launchDataProtectionUrl() {
    var url = "${_getBaseUrl()}data-protection";
    launchWebUrl(url);
  }

  static Future<void> launchWebUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}