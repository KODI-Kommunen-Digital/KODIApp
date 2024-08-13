import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_shelf.dart';

part 'owner_shelves_state.freezed.dart';

@freezed
class OwnerShelvesState with _$OwnerShelvesState {
  const factory OwnerShelvesState.loading() = OwnerShelvesStateLoading;

  const factory OwnerShelvesState.loaded(List<ShelfModel> shelves, List<CategoryModel> categories) =
      OwnerShelvesStateLoaded;

  const factory OwnerShelvesState.error() = OwnerShelvesStateError;
}
