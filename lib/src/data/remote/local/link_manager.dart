import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LinkManager {
  static Map<int, String>? serviceLinks;

  /// Loads service links from a JSON file specified in the .env file.
  static Future<void> loadLinks() async {
    await loadServiceLinks();
  }

  static Future<void> loadServiceLinks() async {
    // Ensure you have SERVICES_LINKS_JSON defined in your .env file
    String path = dotenv.env['SERVICES_LINKS_JSON']!;
    serviceLinks = await _loadLinks(path);
  }

  static Future<Map<int, String>?> _loadLinks(String jsonPath) async {
    try {
      String data = await rootBundle.loadString(jsonPath);
      return (jsonDecode(data) as Map)
          .map((key, value) => MapEntry(int.parse(key), value.toString()));
    } catch (e) {
      return null;
    }
  }

  static String? getServiceLink(String serviceId) {
    // ignore: collection_methods_unrelated_type
    return serviceLinks?[serviceId];
  }
}
