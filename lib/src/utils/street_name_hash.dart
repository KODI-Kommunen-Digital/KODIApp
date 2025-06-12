import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

String getStreetNameHash(String streetName) {
  var bytes = utf8.encode(streetName);
  var digest = sha256.convert(bytes);
  return digest.toString().substring(0, 12);
}