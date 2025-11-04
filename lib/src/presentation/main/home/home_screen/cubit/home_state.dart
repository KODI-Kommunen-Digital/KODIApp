import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeStateInitial;

  const factory HomeState.loading() = HomeStateLoading;

  const factory HomeState.categoryLoading(List<CategoryModel>? location) =
  HomeStatecategoryLoading;

  const factory HomeState.loaded({
    required String banner,
    required List<CategoryModel> category,
    required List<CategoryModel> location,
    required List<ProductModel> recent,
    required bool isRefreshLoader,
    @Default(false) bool isLoadingMore, // Add loading more state
    @Default(1) int currentPage, // Add current page tracking
  }) = HomeStateLoaded;

  const factory HomeState.error(String error) = HomeStateError;
}