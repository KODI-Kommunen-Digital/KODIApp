import 'package:heidi/src/data/model/model_container_shelf_product.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:intl/intl.dart';

class ShelfModel {
  final int id;
  final int? shopId;
  final int? productId;
  final String? productName;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? title;
  final String? description;
  final double? pricePerQuantity;
  final ContainerShelfProductModel? product;

  ShelfModel({
    required this.id,
    this.shopId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.description,
    required this.pricePerQuantity,
    required this.productName,
    this.product,
  });

  factory ShelfModel.fromJson(Map<String, dynamic> json, int cityId) {
    Map<String, dynamic>? productJson = json['product'];
    ContainerShelfProductModel? productModel;
    if (productJson?['description'] != null ||
        productJson?['inventory'] != null) {
      productModel = ContainerShelfProductModel.fromJson(productJson!, cityId);
    }

    return ShelfModel(
        id: json['id'],
        shopId: json['shopId'],
        productId: json['productId'],
        productName: productJson?['title'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
        title: json['title'],
        description: json['description'],
        pricePerQuantity: (json['pricePerQuantity'] != null)
            ? json['pricePerQuantity'].toDouble()
            : null,
        product: productModel);
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
