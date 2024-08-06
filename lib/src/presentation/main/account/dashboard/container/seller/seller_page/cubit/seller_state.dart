import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';

part 'seller_state.freezed.dart';

@freezed
class SellerState with _$SellerState {
  const factory SellerState.loading() = SellerStateLoading;

  const factory SellerState.loaded(List<SellerOrderModel> orderSold) = SellerStateLoaded;

  const factory SellerState.error() = SellerStateError;
}
