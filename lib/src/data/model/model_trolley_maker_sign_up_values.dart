class TrolleyMakerSignUpValues {
  final List<String> titles;
  final List<String> genders;

  TrolleyMakerSignUpValues({required this.titles, required this.genders});

  // Factory method to create a TrolleyMakerSignUpValues from JSON
  factory TrolleyMakerSignUpValues.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerSignUpValues(
      titles: List<String>.from(json['titles']),
      genders: List<String>.from(json['genders']),
    );
  }

  // Method to convert TrolleyMakerSignUpValues instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'titles': titles,
      'genders': genders,
    };
  }
}