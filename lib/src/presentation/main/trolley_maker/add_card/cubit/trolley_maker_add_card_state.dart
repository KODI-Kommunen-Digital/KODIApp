import 'package:freezed_annotation/freezed_annotation.dart';

part 'trolley_maker_add_card_state.freezed.dart';

@freezed
class TrolleyMakerAddCardState with _$TrolleyMakerAddCardState {
  const factory TrolleyMakerAddCardState.initial() = Initial;
  const factory TrolleyMakerAddCardState.loading() = Loading;
  const factory TrolleyMakerAddCardState.success(String cardNumber) = AddCardSuccess;
  const factory TrolleyMakerAddCardState.error(String message) = Error;
}