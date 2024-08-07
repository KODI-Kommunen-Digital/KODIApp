class ContainerCardModel {
  final int id;
  final int status;
  final int expiryMonth;
  final int expiryYear;

  ContainerCardModel(
      {required this.id,
      required this.status,
      required this.expiryMonth,
      required this.expiryYear});

  factory ContainerCardModel.fromJson(Map<String, dynamic> json) {
    return ContainerCardModel(
      id: json['id'] as int,
      status: json['status'] as int,
      expiryMonth: json['expiryMonth'] as int,
      expiryYear: json['expiryYear'] as int,
    );
  }
}
