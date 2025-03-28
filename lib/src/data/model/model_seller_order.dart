import 'package:heidi/src/data/model/model_cart_item.dart';

class SellerOrderModel {
  final int id;
  final int cartId;
  final List<CartItemModel> cartItems;

  SellerOrderModel(
      {required this.id, required this.cartId, required this.cartItems});

  factory SellerOrderModel.fromJson(Map<String, dynamic> json) {
    dynamic cartItemJson = json['cart_items'];
    List<CartItemModel> cartItems = [];
    if (cartItemJson is Map<String, dynamic>) {
      cartItems = [CartItemModel.fromJson(cartItemJson)];
    } else {
      final list = List.from(cartItemJson ?? []).map((item) {
        return CartItemModel.fromJson(item);
      }).toList();
      cartItems = list;
    }

    return SellerOrderModel(
        id: json['orderId'], cartId: json['cartId'], cartItems: cartItems);
  }

  double getTotalPrice() {
    double total = 0;
    for(CartItemModel item in cartItems) {
      total += item.totalPrice;
    }
    return total;
  }
}
