import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product_request.dart';

part 'seller_state.freezed.dart';

@freezed
class SellerState with _$SellerState {
  const factory SellerState.loading() = SellerStateLoading;

  const factory SellerState.loaded(List<OrderModel> orderSold,
      List<ProductRequestModel> productRequests) = SellerStateLoaded;

  const factory SellerState.error() = SellerStateError;
}
