import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_state.dart';

class OwnerProductsCubit extends Cubit<OwnerProductsState> {
  OwnerProductsCubit() : super(const OwnerProductsState.loading());
  late StoreModel store;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerProductsState.loading());
    }
    final products = await ContainerRepository.getStoreProducts(
        cityId: store.cityId, storeId: store.id, pageNo: 1);


    emit(OwnerProductsState.loaded(
        products ?? []));
  }

  Future<List<ContainerProductModel>> newProducts(int pageNo) async {
    final newProducts = await ContainerRepository.getStoreProducts(
        cityId: store.cityId, storeId: store.id, pageNo: pageNo);
    return newProducts ?? [];
  }

  Future<List<ProductRequestModel>> newRequests(int pageNo) async {
    final newRequests = await ContainerRepository.getStoreProductRequests(
        cityId: store.cityId, storeId: store.id, pageNo: pageNo, status: 0);
    return newRequests ?? [];
  }

  Future<List<ShelfModel>> getShelves() async {
    final shelves =
        await ContainerRepository.getEmptyStoreShelves(store.cityId, store.id, loading: true);
    return shelves ?? [];
  }

  Future<bool> deleteProduct(ContainerProductModel product) async {
    final success = await ContainerRepository.deleteProduct(
        product.cityId, product.shopId, product.id);
    return success;
  }
}
