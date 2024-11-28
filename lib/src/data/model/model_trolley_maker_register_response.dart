class TrolleyMakerRegisterResponse {
  final String cardID;
  final String region;
  final String cardName;

  TrolleyMakerRegisterResponse({
    required this.cardID,
    required this.region,
    required this.cardName,
  });

  // Factory method to create an instance from a JSON map
  factory TrolleyMakerRegisterResponse.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerRegisterResponse(
      cardID: json['cardID'],
      region: json['region'],
      cardName: json['cardName'],
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'cardID': cardID,
      'region': region,
      'cardName': cardName,
    };
  }
}