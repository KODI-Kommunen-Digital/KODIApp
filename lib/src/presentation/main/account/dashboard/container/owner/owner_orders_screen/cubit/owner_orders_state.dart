import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_order.dart';

part 'owner_orders_state.freezed.dart';

@freezed
class OwnerOrdersState with _$OwnerOrdersState {
  const factory OwnerOrdersState.loading() = OwnerOrdersStateLoading;

  const factory OwnerOrdersState.loaded(List<OrderModel> orders) = OwnerOrdersStateLoaded;

  const factory OwnerOrdersState.error() = OwnerOrdersStateError;
}
