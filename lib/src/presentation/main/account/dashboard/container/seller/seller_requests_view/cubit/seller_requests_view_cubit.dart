import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_seller_request.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_requests_view/cubit/seller_requests_view_state.dart';

class SellerRequestsViewCubit extends Cubit<SellerRequestsViewState> {
  SellerRequestsViewCubit() : super(const SellerRequestsViewState.loading());

  bool isOwner = false;
  StoreModel? store;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const SellerRequestsViewState.loading());
    }

    List<SellerRequestModel>? requests;
    if (isOwner) {
      requests = await ContainerRepository.getSellerRequestsOwner(
          1, store!.cityId, store!.id);
    } else {
      requests = await ContainerRepository.getSellerRequests(1);
    }

    emit(SellerRequestsViewState.loaded(requests ?? []));
  }

  Future<List<SellerRequestModel>> newOrders(int pageNo) async {
    List<SellerRequestModel>? newSoldOrders;
    if (isOwner) {
      newSoldOrders = await ContainerRepository.getSellerRequestsOwner(
          pageNo, store!.cityId, store!.id);
    } else {
      newSoldOrders = await ContainerRepository.getSellerRequests(pageNo);
    }
    return newSoldOrders ?? [];
  }
}
