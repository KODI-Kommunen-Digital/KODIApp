import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const CustomerState.loading());
    }

    final UserModel? user = await UserRepository.loadUser();
    if (user != null) {
      final List<OrderModel>? userOrders =
          await ContainerRepository.getCustomerOrders(user.id, 1);
      emit(CustomerState.loaded(userOrders ?? []));
    } else {
      emit(const CustomerState.error());
      return;
    }
  }

  Future<List<OrderModel>> newOrders(int pageNo) async {
    final UserModel? user = await UserRepository.loadUser();
    if (user != null) {
      final List<OrderModel>? userOrders =
          await ContainerRepository.getCustomerOrders(user.id, pageNo);
      return userOrders ?? [];
    }
    return [];
  }
}
