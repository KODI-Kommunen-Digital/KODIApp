class TrolleyMakerErrorResponse {
  final String errorMessage;
  final String errorStatusCode;
  final int httpStatusCode;

  TrolleyMakerErrorResponse({
    required this.errorMessage,
    required this.errorStatusCode,
    required this.httpStatusCode,
  });

  // Factory constructor to create a TrolleyMakerErrorResponse instance from JSON
  factory TrolleyMakerErrorResponse.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerErrorResponse(
      errorMessage: json['errorMessage'] ?? 'An unknown error occurred',
      errorStatusCode: json['errorStatusCode'] ?? 'unknown_error',
      httpStatusCode: json['httpStatusCode'] ?? 500,
    );
  }

  // Method to convert a TrolleyMakerErrorResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'errorMessage': errorMessage,
      'errorStatusCode': errorStatusCode,
      'httpStatusCode': httpStatusCode,
    };
  }

  @override
  String toString() {
    return 'TrolleyMakerErrorResponse(errorMessage: $errorMessage, errorStatusCode: $errorStatusCode, httpStatusCode: $httpStatusCode)';
  }

  static TrolleyMakerErrorResponse unknownError() {
    return TrolleyMakerErrorResponse(errorMessage:"Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut.", errorStatusCode: "unknwon_error", httpStatusCode: 520);
  }
}