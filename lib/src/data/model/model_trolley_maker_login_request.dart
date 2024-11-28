

class TrolleyMakerLoginRequest {
  final String cardID;
  final String password;

  TrolleyMakerLoginRequest({
    required this.cardID,
    required this.password,
  });

  // Convert a TrolleyMakerLoginRequest instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardID': cardID,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'TrolleyMakerLoginRequest(cardID: $cardID, password: $password)';
  }
}