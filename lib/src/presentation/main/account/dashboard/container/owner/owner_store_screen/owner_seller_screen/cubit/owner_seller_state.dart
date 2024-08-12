import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_seller.dart';

part 'owner_seller_state.freezed.dart';

@freezed
class OwnerSellerState with _$OwnerSellerState {
  const factory OwnerSellerState.loading() = OwnerSellerStateLoading;

  const factory OwnerSellerState.loaded(List<SellerModel> seller) = OwnerSellerStateLoaded;

  const factory OwnerSellerState.error() = OwnerSellerStateError;
}
