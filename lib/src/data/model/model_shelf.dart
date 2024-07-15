import 'dart:convert';

import 'package:heidi/src/data/model/model_container_product.dart';

class ShelfModel {
  final int id;
  final int shopId;
  final int productId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String title;
  final String description;
  final ContainerProductModel product;

  ShelfModel(
      {required this.id,
      required this.shopId,
      required this.productId,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.title,
      required this.description,
      required this.product});

  factory ShelfModel.fromJson(Map<String, dynamic> json, int cityId) {
    String productJson = json['product'];
    ContainerProductModel productModel =
        ContainerProductModel.fromJson(jsonDecode(productJson), cityId);

    return ShelfModel(
        id: json['id'],
        shopId: json['shopId'],
        productId: json['productId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
        title: json['title'],
        description: json['description'],
        product: productModel);
  }
}
