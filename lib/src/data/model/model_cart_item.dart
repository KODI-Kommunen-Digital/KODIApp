class CartItemModel {
  final int id;
  final int quantity;
  final int productId;
  final double totalPrice;
  final String name;
  final double pricePerQuantity;

  CartItemModel(
      {required this.id,
      required this.quantity,
      required this.productId,
      required this.totalPrice,
      required this.name,
      required this.pricePerQuantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        id: json['cartItemId'] ?? 0,
        quantity: (json['quantity'] == null)
            ? (json['totalQuantity'] != null)
                ? int.parse(json['totalQuantity'])
                : 0
            : json['quantity'],
        productId: json['productId'],
        totalPrice: json['totalPrice'].toDouble(),
        name: json['productName'],
        pricePerQuantity: json['pricePerQuantity'].toDouble());
  }
}
