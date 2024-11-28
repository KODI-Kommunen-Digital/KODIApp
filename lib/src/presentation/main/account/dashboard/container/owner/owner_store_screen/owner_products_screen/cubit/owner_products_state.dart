import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_container_product.dart';

part 'owner_products_state.freezed.dart';

@freezed
class OwnerProductsState with _$OwnerProductsState {
  const factory OwnerProductsState.loading() = OwnerProductsStateLoading;

  const factory OwnerProductsState.loaded(
      List<ContainerProductModel> products) = OwnerProductsStateLoaded;

  const factory OwnerProductsState.error() = OwnerProductsStateError;
}
