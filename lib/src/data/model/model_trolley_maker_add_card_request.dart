import 'package:json_annotation/json_annotation.dart';

part 'model_trolley_maker_add_card_request.g.dart';

@JsonSerializable()
class TrolleyMakerAddCardRequest {
  final String newCardToAdd;
  final String newCardProductionNumber;
  final int cardIDToLock;

  TrolleyMakerAddCardRequest({
    required this.newCardToAdd,
    required this.newCardProductionNumber,
    required this.cardIDToLock,
  });

  factory TrolleyMakerAddCardRequest.fromJson(Map<String, dynamic> json) =>
      _$TrolleyMakerAddCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TrolleyMakerAddCardRequestToJson(this);
}