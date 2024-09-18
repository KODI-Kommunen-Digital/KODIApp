import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

class ProductRequestModel {
  final int id;
  final String title;
  final String description;
  final int? reqType;
  final int? sellerId;
  final int shopId;
  final int productId;
  final double price;
  final int count;
  final int threshold;
  final int? minCount;
  final int? maxCount;
  final int? inventory;
  final int status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? barcode; //TODO make not nullable once backend ready

  ProductRequestModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.reqType,
      required this.sellerId,
      required this.shopId,
      required this.productId,
      required this.price,
      required this.count,
      required this.threshold,
      required this.minCount,
      required this.maxCount,
      required this.inventory,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.barcode});

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) {
    return ProductRequestModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        reqType: json["reqType"],
        sellerId: json["sellerId"],
        shopId: json["shopId"],
        productId: json["productId"],
        price: json["price"].toDouble(),
        count: json["count"],
        threshold: json["threshold"],
        minCount: json["minCount"],
        maxCount: json["maxCount"],
        inventory: json["inventory"],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
        barcode: json["barcode"]);
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
