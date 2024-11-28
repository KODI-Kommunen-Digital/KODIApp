import 'package:freezed_annotation/freezed_annotation.dart';

part 'trolley_maker_cards_state.freezed.dart';

@freezed
class TrolleyMakerCardsState with _$TrolleyMakerCardsState {
  const factory TrolleyMakerCardsState.initial() = Initial;
  const factory TrolleyMakerCardsState.loading() = Loading;
  const factory TrolleyMakerCardsState.success(String cardName, List<int> cardIDs) = CardDataSuccess;
  const factory TrolleyMakerCardsState.error(String message) = LoadFailure;
}