import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

import 'model_user.dart';

class SellerModel {
  final int id;
  final int userId;
  final int shopId;
  final String? description;
  final String? title;
  final int? status;
  final String? createdAt;
  final String? deletedAt;
  final String? updatedAt;
  UserModel? user;

  SellerModel(
      {required this.id,
      required this.userId,
      required this.shopId,
      required this.description,
      required this.status,
      required this.title,
      required this.createdAt,
      required this.deletedAt,
      required this.updatedAt,
      this.user});

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
        id: json['id'],
        userId: json['userId'],
        shopId: json['shopId'],
        description: json['description'],
        title: json['title'],
        status: json['status'],
        createdAt: json['createdAt'],
        deletedAt: json['deletedAt'],
        updatedAt: json['updatedAt']);
  }

  factory SellerModel.updateUser(SellerModel seller, UserModel user) {
    return SellerModel(
        id: seller.id,
        userId: seller.userId,
        shopId: seller.shopId,
        description: seller.description,
        status: seller.status,
        title: seller.title,
        createdAt: seller.createdAt,
        deletedAt: seller.deletedAt,
        updatedAt: seller.updatedAt,
        user: user);
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
