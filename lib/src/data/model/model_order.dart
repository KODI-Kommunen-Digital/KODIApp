class OrderModel {
  final int id;
  final int shopId;
  final int amount;
  final int products;
  final int? cartId;
  final int? userId;
  final int? paymentId;
  final int? discount;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final Map<String, dynamic>? cartItems;

  OrderModel(
      {required this.id,
      required this.shopId,
      required this.amount,
      required this.products,
      required this.cartId,
      required this.userId,
      required this.paymentId,
      required this.discount,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.cartItems});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      shopId: json['shopId'],
      amount: json['amount'],
      products: json['products'],
      cartId: json['cartId'],
      userId: json['userId'],
      paymentId: json['paymentId'],
      discount: json['discount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      cartItems: json['cartItems']
    );
  }
}
