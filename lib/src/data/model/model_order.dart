import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

class OrderModel {
  final int id;
  final int shopId;
  final int amount;
  final int? cartId;
  final int? userId;
  final int? paymentId;
  final int? discount;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<ShelfModel> shelves;

  OrderModel(
      {required this.id,
      required this.shopId,
      required this.amount,
      required this.cartId,
      required this.userId,
      required this.paymentId,
      required this.discount,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.shelves});

  factory OrderModel.fromJson(Map<String, dynamic> json, int? cityId) {
    List<ShelfModel> shelves = [];
    List shelfJson = json['products'];
    for (var shelf in shelfJson) {
      //TODO check cityID
      shelves.add(ShelfModel.fromJson(shelf, cityId ?? 0));
    }

    return OrderModel(
        id: json['id'],
        shopId: json['shopId'],
        amount: json['amount'],
        cartId: json['cartId'],
        userId: json['userId'],
        paymentId: json['paymentId'],
        discount: json['discount'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
        shelves: shelves);
  }

  double getTotalPrice() {
    double total = 0;
    for (ShelfModel shelf in shelves) {
      total += shelf.pricePerQuantity ?? 0 * amount;
    }
    return total;
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
