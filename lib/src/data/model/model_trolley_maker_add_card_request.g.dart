// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_trolley_maker_add_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrolleyMakerAddCardRequest _$TrolleyMakerAddCardRequestFromJson(
        Map<String, dynamic> json) =>
    TrolleyMakerAddCardRequest(
      newCardToAdd: json['newCardToAdd'] as String,
      newCardProductionNumber: json['newCardProductionNumber'] as String,
      cardIDToLock: (json['cardIDToLock'] as num).toInt(),
    );

Map<String, dynamic> _$TrolleyMakerAddCardRequestToJson(
        TrolleyMakerAddCardRequest instance) =>
    <String, dynamic>{
      'newCardToAdd': instance.newCardToAdd,
      'newCardProductionNumber': instance.newCardProductionNumber,
      'cardIDToLock': instance.cardIDToLock,
    };
