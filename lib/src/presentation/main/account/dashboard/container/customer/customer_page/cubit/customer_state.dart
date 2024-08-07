import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_order.dart';

part 'customer_state.freezed.dart';

@freezed
class CustomerState with _$CustomerState {
  const factory CustomerState.loading() = CustomerStateLoading;

  const factory CustomerState.loaded(List<OrderModel> orderSold) = CustomerStateLoaded;

  const factory CustomerState.error() = CustomerStateError;
}
