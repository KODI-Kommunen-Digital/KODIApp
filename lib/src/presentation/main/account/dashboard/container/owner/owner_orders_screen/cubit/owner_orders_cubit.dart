import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_orders_screen/cubit/owner_orders_state.dart';

class OwnerOrdersCubit extends Cubit<OwnerOrdersState> {
  OwnerOrdersCubit() : super(const OwnerOrdersState.loading());

  late StoreModel store;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerOrdersState.loading());
    }
    final orders = await ContainerRepository.getStoreOrders(store.cityId, store.id, 1);
    emit(OwnerOrdersState.loaded(orders ?? []));
  }

  Future<List<OrderModel>> newOrders(int pageNo) async {
    final newOrders = await ContainerRepository.getStoreOrders(store.cityId, store.id, pageNo);
    return newOrders ?? [];
  }
}
