import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_seller_request.dart';

part 'seller_requests_view_state.freezed.dart';

@freezed
class SellerRequestsViewState with _$SellerRequestsViewState {
  const factory SellerRequestsViewState.loading() = SellerRequestsViewStateLoading;

  const factory SellerRequestsViewState.loaded(List<SellerRequestModel> requests) = SellerRequestsViewStateLoaded;

  const factory SellerRequestsViewState.error() = SellerRequestsViewStateError;
}
