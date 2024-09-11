import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';

part 'owner_category_state.freezed.dart';

@freezed
class OwnerCategoryState with _$OwnerCategoryState {
  const factory OwnerCategoryState.loading() = OwnerCategoryStateLoading;

  const factory OwnerCategoryState.loaded(List<CategoryModel> categories, bool isSubCategory) = OwnerCategoryStateLoaded;

  const factory OwnerCategoryState.error() = OwnerCategoryStateError;
}
