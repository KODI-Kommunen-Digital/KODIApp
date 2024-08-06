import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'seller_state.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit() : super(const SellerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const SellerState.loading());
    }

    final List<SellerOrderModel>? soldOrders =
        await ContainerRepository.getSellerOrders(1);

    emit(SellerState.loaded(soldOrders ?? []));
  }

  Future<List<SellerOrderModel>> newOrders(int pageNo) async {
    final List<SellerOrderModel>? newSoldOrders =
        await ContainerRepository.getSellerOrders(pageNo);
    return newSoldOrders ?? [];
  }
}
