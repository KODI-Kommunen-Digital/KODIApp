import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_seller.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_seller_screen/cubit/owner_seller_state.dart';

class OwnerSellerCubit extends Cubit<OwnerSellerState> {
  OwnerSellerCubit() : super(const OwnerSellerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerSellerState.loading());
    }
    //final seller = await ContainerRepository.;
    emit(const OwnerSellerState.loaded([]));
  }

  Future<List<SellerModel>> newSeller(int pageNo) async {
  //final newSeller = await ContainerRepository.;
  return [];
  }
}
