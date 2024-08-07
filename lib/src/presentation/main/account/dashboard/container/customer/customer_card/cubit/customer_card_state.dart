import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_container_card.dart';
import 'package:heidi/src/data/model/model_container_transaction.dart';

part 'customer_card_state.freezed.dart';

@freezed
class CustomerCardState with _$CustomerCardState {
  const factory CustomerCardState.loading() = CustomerCardStateLoading;

  const factory CustomerCardState.loaded(List<ContainerCardModel> cards,
      List<ContainerTransactionModel>? transactions) = CustomerCardStateLoaded;

  const factory CustomerCardState.error() = CustomerCardStateError;
}
