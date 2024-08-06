import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const CustomerState.loading());
    }
    final List<OrderModel> soldOrders = [];
    await Future.delayed(const Duration(seconds: 2));
    emit(CustomerState.loaded(soldOrders));
  }

  Future<List<OrderModel>> newOrders(int pageNo) async {
    return [];
  }
}
