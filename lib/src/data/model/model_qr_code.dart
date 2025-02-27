class QRCode {
  final String data;
  final String validUntil;
  final int accountId;

  QRCode(
      {required this.data, required this.validUntil, required this.accountId});

  factory QRCode.fromJson(Map<String, dynamic> json) {
    return QRCode(
        data: json['data'],
        validUntil: json['validUntil'],
        accountId: json['accountId'] ?? 0);
  }
}
