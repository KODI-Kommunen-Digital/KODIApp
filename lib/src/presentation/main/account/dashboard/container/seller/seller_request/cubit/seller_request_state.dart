import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';

part 'seller_request_state.freezed.dart';

@freezed
class SellerRequestState with _$SellerRequestState {
  const factory SellerRequestState.loading() = SellerRequestStateLoading;

  const factory SellerRequestState.loaded(List<CategoryModel> cities,
      List<StoreModel> stores, int? selectedCity) = SellerRequestStateLoaded;

  const factory SellerRequestState.error() = SellerRequestStateError;
}
