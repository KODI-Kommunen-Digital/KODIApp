import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_store.dart';

part 'edit_store_state.freezed.dart';

@freezed
class EditStoreState with _$EditStoreState {
  const factory EditStoreState.loading() = EditStoreStateLoading;

  const factory EditStoreState.loaded(StoreModel store) = EditStoreStateLoaded;

  const factory EditStoreState.error(String error) = EditStoreStateError;

  const factory EditStoreState.success() = EditStoreStateSuccess;
}
