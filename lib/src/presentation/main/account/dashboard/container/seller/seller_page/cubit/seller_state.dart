import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/model/model_store.dart';

part 'seller_state.freezed.dart';

@freezed
class SellerState with _$SellerState {
  const factory SellerState.loading() = SellerStateLoading;

  const factory SellerState.loadedOrders(List<SellerOrderModel> orderSold) =
      SellerStateLoadedOrders;

  const factory SellerState.loadedProducts(
      List<ContainerProductModel>? products,
      List<CategoryModel>? categories,
      List<CategoryModel>? subCategories,
      List<StoreModel> stores,
      StoreModel? selectedStore) = SellerStateLoadedProducts;

  const factory SellerState.error() = SellerStateError;
}
