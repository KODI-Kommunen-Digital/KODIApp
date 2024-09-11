// ignore_for_file: file_names

import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

class ContainerProductModel {
  final int id;
  final int cityId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String title;
  final String description;
  final double price;
  final double tax;
  final int inventory;
  final int minCount;
  final int maxCount;
  final int sellerId;
  final int shopId;
  final int categoryId;
  final int subCategoryId;
  final String? meta;
  final bool isActive;
  final bool isArchived;
  final int? deletedBy;
  final List<String>? productImages;
  final String? barcode; //TODO make not nullable once backend integrated

  ContainerProductModel(
      {required this.id,
      required this.cityId,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.title,
      required this.description,
      required this.price,
      required this.tax,
      required this.inventory,
      required this.minCount,
      required this.maxCount,
      required this.sellerId,
      required this.shopId,
      required this.categoryId,
      required this.subCategoryId,
      required this.meta,
      required this.isActive,
      required this.isArchived,
      required this.deletedBy,
      required this.productImages,
      required this.barcode});

  factory ContainerProductModel.fromJson(Map<String, dynamic> json, int cityId) {
    return ContainerProductModel(
        id: json['id'],
        cityId: cityId,
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
        title: json['title'],
        description: json['description'],
        price: json['price'].toDouble(),
        tax: (json['tax'] ?? 0).toDouble(),
        inventory: json['inventory'] ?? 0,
        maxCount: json['maxCount'] ?? 0,
        minCount: json['minCount'] ?? 0,
        sellerId: json['sellerId'],
        shopId: json['shopId'],
        categoryId: json['categoryId'],
        subCategoryId: json['subCategoryId'],
        meta: json['meta'],
        isActive: (json['isActive'] ?? 0) == 1,
        isArchived: (json['isArchived'] ?? 0) == 1,
        deletedBy: json['deletedBy'],
        barcode: json['barcode'],
        productImages: (json['productImages'] ?? []).cast<String>());
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
