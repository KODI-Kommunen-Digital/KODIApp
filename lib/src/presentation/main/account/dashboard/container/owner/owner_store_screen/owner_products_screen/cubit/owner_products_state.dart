import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';

part 'owner_products_state.freezed.dart';

@freezed
class OwnerProductsState with _$OwnerProductsState {
  const factory OwnerProductsState.loading() = OwnerProductsStateLoading;

  const factory OwnerProductsState.loaded(List<ContainerProductModel> products, List<CategoryModel> categories, List<CategoryModel> subCategories) = OwnerProductsStateLoaded;

  const factory OwnerProductsState.error() = OwnerProductsStateError;
}
