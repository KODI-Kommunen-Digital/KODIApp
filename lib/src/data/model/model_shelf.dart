import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:intl/intl.dart';

class ShelfModel {
  final int id;
  final int? shopId;
  final int? productId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? title;
  final String? description;
  final double? pricePerQuantity;
  final ContainerProductModel? product;

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
    required this.product,
  });

  factory ShelfModel.fromJson(Map<String, dynamic> json, int cityId) {
    Map<String, dynamic>? productJson = json['product'];
    ContainerProductModel? productModel;
    if (productJson?['description'] != null ||
        productJson?['inventory'] != null) {
      productModel = ContainerProductModel.fromJson(productJson!, cityId);
    }

    return ShelfModel(
        id: json['id'],
        shopId: json['shopId'],
        productId: json['productId'],
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

  factory ShelfModel.updateProduct(
      ContainerProductModel product, ShelfModel shelf) {
    return ShelfModel(
        id: shelf.id,
        productId: product.id,
        createdAt: shelf.createdAt,
        updatedAt: shelf.updatedAt,
        deletedAt: shelf.deletedAt,
        title: shelf.title,
        description: shelf.description,
        pricePerQuantity: shelf.pricePerQuantity,
        product: product);
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
