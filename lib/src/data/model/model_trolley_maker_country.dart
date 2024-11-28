class TrolleyMakerCountry {
  final String value;
  final String name;

  TrolleyMakerCountry({required this.value, required this.name});

  // Factory method to create a TrolleyMakerCountry from JSON
  factory TrolleyMakerCountry.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerCountry(
      value: json['value'],
      name: json['country'],
    );
  }

  // Method to convert Country instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'country': name,
    };
  }
}