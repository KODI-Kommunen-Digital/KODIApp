import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

class StoreModel {
  final int id;
  final String name;
  final String description;
  final int cityId;
  final String? createdAt;
  final String? address;
  final String? latitude;
  final String? longitude;

  StoreModel({required this.id,
    required this.name,
    required this.description,
    required this.cityId,
    this.createdAt,
    this.address,
    this.latitude,
    this.longitude});

  factory StoreModel.fromJson(Map<String, dynamic> json, {int? cityId}) {
    return StoreModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cityId: json['cityId'] ?? cityId,
        createdAt: json['createdAt'],
        address: json['address'],
        latitude: json['latitude']?.toString(),
        longitude: json['longitude']?.toString());
  }

  String formatDate() {
    try {
      final dateTime = DateTime.parse(createdAt ?? '');
      return DateFormat('dd.MM.yyyy').format(dateTime);
    } on FormatException catch (e) {
      logError("Error parsing date string: $e");
      return "";
    }
  }
}
