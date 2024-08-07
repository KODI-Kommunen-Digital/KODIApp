import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:intl/intl.dart';

class ContainerTransactionModel {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int cardId;
  final int amount;
  final int type;

  ContainerTransactionModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.cardId,
      required this.amount,
      required this.type});

  factory ContainerTransactionModel.fromJson(Map<String, dynamic> json) {
    return ContainerTransactionModel(
      id: json['id'] as int,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      cardId: json['cardId'] as int,
      amount: json['amount'] as int,
      type: json['type'] as int,
    );
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
