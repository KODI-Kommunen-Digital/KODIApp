import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_store.dart';

part 'owner_state.freezed.dart';

@freezed
class OwnerState with _$OwnerState {
  const factory OwnerState.loading() = OwnerStateLoading;

  const factory OwnerState.loaded(List<StoreModel> stores) = OwnerStateLoaded;

  const factory OwnerState.error() = OwnerStateError;
}
