// card_response.dart

class TrolleyMakerLoginResponse {
  final List<int> cardIDs;
  final List<CardDetail> cards;
  final String region;
  final String cardName;
  final String xApiToken;

  TrolleyMakerLoginResponse({
    required this.cardIDs,
    required this.cards,
    required this.region,
    required this.cardName,
    required this.xApiToken,
  });

  // Factory constructor to create a TrolleyMakerLoginResponse instance from JSON
  factory TrolleyMakerLoginResponse.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerLoginResponse(
      cardIDs: List<int>.from(json['cardIDs']),
      cards: (json['cards'] as List)
          .map((item) => CardDetail.fromJson(item))
          .toList(),
      region: json['region'],
      cardName: json['cardName'],
      xApiToken: json['x_api_token'],
    );
  }

  // Method to convert a TrolleyMakerLoginResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardIDs': cardIDs,
      'cards': cards.map((card) => card.toJson()).toList(),
      'region': region,
      'cardName': cardName,
      'x_api_token': xApiToken,
    };
  }

  @override
  String toString() {
    return 'TrolleyMakerLoginResponse(cardIDs: $cardIDs, cards: $cards, region: $region, cardName: $cardName, xApiToken: $xApiToken)';
  }
}

class CardDetail {
  final int cardId;
  final bool isIndividualCard;

  CardDetail({
    required this.cardId,
    required this.isIndividualCard,
  });

  // Factory constructor to create a CardDetail instance from JSON
  factory CardDetail.fromJson(Map<String, dynamic> json) {
    return CardDetail(
      cardId: json['cardId'],
      isIndividualCard: json['isIndividualCard'],
    );
  }

  // Method to convert a CardDetail instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'isIndividualCard': isIndividualCard,
    };
  }

  @override
  String toString() {
    return 'CardDetail(cardId: $cardId, isIndividualCard: $isIndividualCard)';
  }
}
