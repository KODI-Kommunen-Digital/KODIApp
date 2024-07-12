import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'seller_state.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit() : super(const SellerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const SellerState.loading());
    }
    final List<OrderModel> soldOrders = [
      OrderModel(
          id: 1,
          shopId: 1,
          amount: 100,
          products: 5,
          cartId: 1,
          userId: 1,
          paymentId: 12341,
          discount: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt",
          cartItems: {"cartItems": 50}),
      OrderModel(
          id: 2,
          shopId: 1,
          amount: 200,
          products: 10,
          cartId: 1,
          userId: 1,
          paymentId: 122341,
          discount: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt",
          cartItems: {"cartItems": 10})
    ];
    final List<ProductRequestModel> productRequests = [
      ProductRequestModel(
          id: 1,
          title: "title",
          description: "description",
          reqType: 1,
          sellerId: 1,
          shopId: 1,
          productId: 1,
          price: 100,
          count: 1,
          threshold: 1,
          maxCount: 1,
          status: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt"),
      ProductRequestModel(
          id: 2,
          title: "titl12312312e",
          description: "descri123123ption",
          reqType: 1,
          sellerId: 1,
          shopId: 1,
          productId: 1,
          price: 100,
          count: 1,
          threshold: 1,
          maxCount: 1,
          status: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt")
    ];

    await Future.delayed(const Duration(seconds: 2));
    emit(SellerState.loaded(soldOrders, productRequests));
  }

  Future<List<OrderModel>> newOrders(int pageNo) async {
    return [];
  }
}
