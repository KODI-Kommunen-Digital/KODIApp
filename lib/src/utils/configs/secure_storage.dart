import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const String keyCardList = "card_list";

  Future<void> saveIntList(String key, List<int>? value) async {
    if (value == null) return;
    String jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  Future<List<int>?> getIntList(String key) async {
    String? jsonString = await _storage.read(key: key);
    if (jsonString == null) return null;
    List<dynamic> decodedList = jsonDecode(jsonString);
    return decodedList.cast<int>();
  }

  static SecureStorage getInstance() {
    return SecureStorage();
  }
}
