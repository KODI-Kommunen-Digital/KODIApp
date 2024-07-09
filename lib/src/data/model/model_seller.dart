class SellerModel {
  final int id;
  final int userId;
  final int shopId;
  final String title;
  final String description;
  final int status;
  final String? createdAt;
  final String? deletedAt;
  final String? updatedAt;

  SellerModel(
      {required this.id,
      required this.userId,
      required this.shopId,
      required this.title,
      required this.description,
      required this.status,
      required this.createdAt,
      required this.deletedAt,
      required this.updatedAt});

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
        id: json['id'],
        userId: json['userId'],
        shopId: json['shopId'],
        title: json['title'],
        description: json['description'],
        status: json['status'],
        createdAt: json['createdAt'],
        deletedAt: json['deletedAt'],
        updatedAt: json['updatedAt']);
  }
}
