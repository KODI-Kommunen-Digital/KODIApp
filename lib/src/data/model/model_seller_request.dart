
class SellerRequestModel {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int userId;
  final int shopId;
  final String title;
  final String description;
  final int status;
  final int? paymentOwed;
  final String? username;

  SellerRequestModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.userId,
      required this.shopId,
      required this.title,
      required this.description,
      required this.status,
      required this.paymentOwed,
      required this.username});

  factory SellerRequestModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? jsonUser = json['user'];
    return SellerRequestModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      userId: json['userId'],
      shopId: json['shopId'],
      title: json['title'],
      description: json['description'] ?? '',
      status: json['status'],
      paymentOwed: json['paymentOwed'],
      username: jsonUser?['username']
    );
  }
}
