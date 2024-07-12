import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const CustomerState.loading());
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

    await Future.delayed(const Duration(seconds: 2));
    emit(CustomerState.loaded(soldOrders));
  }

  Future<List<OrderModel>> newOrders(int pageNo) async {
    return [];
  }
}
