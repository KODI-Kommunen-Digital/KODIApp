import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';

part 'create_product_state.freezed.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState.loading() = CreateProductStateLoading;

  const factory CreateProductState.loaded(
      List<CategoryModel> cities,
      List<StoreModel> stores,
      int? selectedCity,
      List<CategoryModel> categories,
      List<CategoryModel> subCategories,
      Map<String, dynamic>? productDetails,
      StoreModel? selectedStore,
      CategoryModel? selectedCategory,
      CategoryModel? selectedSubCategory) = CreateProductStateLoaded;

  const factory CreateProductState.error() = CreateProductStateError;
}
