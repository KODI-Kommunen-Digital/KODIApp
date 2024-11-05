import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_trolley_maker_card_balance_transaction_response.dart';

part 'trolley_maker_my_credit_state.freezed.dart';

@freezed
class TrolleyMakerMyCreditState with _$TrolleyMakerMyCreditState {
  const factory TrolleyMakerMyCreditState.initial() = Initial;
  const factory TrolleyMakerMyCreditState.loading() = Loading;
  const factory TrolleyMakerMyCreditState.success(CardBalanceAndTransactionResponse cardDetails) = MyCreditSuccess;
  const factory TrolleyMakerMyCreditState.error(String message) = ApiError;
}