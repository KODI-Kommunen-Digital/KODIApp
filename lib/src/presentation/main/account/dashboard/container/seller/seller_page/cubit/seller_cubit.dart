import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'seller_state.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit() : super(const SellerState.loading());

  StoreModel? store;
  bool? loadMyProducts;

  Future<void> onLoad(bool isRefreshLoader, bool isProducts) async {
    if (!isRefreshLoader) {
      emit(const SellerState.loading());
    }

    if (isProducts) {
      final List<StoreModel>? stores =
          await ContainerRepository.loadStoresSeller(null);
      if (stores == null) {
        emit(const SellerState.error());
        return;
      }
      if (store != null) {
        List<ContainerProductModel>? products;
        if (loadMyProducts ?? false) {
          products = await ContainerRepository.getSellerProducts(
              cityId: store!.cityId, storeId: store!.id, pageNo: 1);
        } else {
          products = await ContainerRepository.getStoreProducts(
              cityId: store!.cityId, storeId: store!.id, pageNo: 1);
        }

        final categories = await ContainerRepository.loadStoreCategories(
            store!.cityId, store!.id);

        List<CategoryModel> subCategories = [];
        if (categories != null) {
          for (var category in categories) {
            final subCategory =
                await ContainerRepository.loadStoreSubCategories(
                    store!.cityId, store!.id, category.id);
            if (subCategory != null) {
              subCategories.addAll(subCategory);
            }
          }
        }
        emit(SellerState.loadedProducts(products ?? [],
            categories ?? [], subCategories, stores, store));
      } else {
        emit(SellerState.loadedProducts(null, null, null, stores, store));
      }
    } else {
      final List<SellerOrderModel>? soldOrders =
          await ContainerRepository.getSellerOrders(1);

      emit(SellerState.loadedOrders(soldOrders ?? []));
    }
  }

  Future<List<SellerOrderModel>> newOrders(int pageNo) async {
    final List<SellerOrderModel>? newSoldOrders =
        await ContainerRepository.getSellerOrders(pageNo);
    return newSoldOrders ?? [];
  }

  Future<List<ContainerProductModel>> newProducts(int pageNo) async {
    if (store != null) {
      List<ContainerProductModel>? newProducts;
      if (loadMyProducts ?? false) {
        newProducts = await ContainerRepository.getSellerProducts(
            cityId: store!.cityId, storeId: store!.id, pageNo: pageNo);
      } else {
        newProducts = await ContainerRepository.getStoreProducts(
            cityId: store!.cityId, storeId: store!.id, pageNo: pageNo);
      }
      if (newProducts != null) {
        return newProducts;
      }
    }
    return [];
  }

  Future<List<ProductRequestModel>> newRequests(int pageNo) async {
    final newRequests = await ContainerRepository.getStoreProductRequests(
        cityId: store!.cityId, storeId: store!.id, pageNo: pageNo, status: 0);
    return newRequests ?? [];
  }
}
