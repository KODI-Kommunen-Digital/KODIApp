import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_state.dart';

class OwnerProductsCubit extends Cubit<OwnerProductsState> {
  OwnerProductsCubit() : super(const OwnerProductsState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerProductsState.loading());
    }
    //final orders = await ContainerRepository.getOwnerProcuts();
    emit(const OwnerProductsState.loaded([]));
  }

  Future<List<ContainerProductModel>> newProducts(int pageNo) async {
    //final newProducts = await ContainerRepository.getOwnerProcuts(pageNo);
    return [];
  }
}
