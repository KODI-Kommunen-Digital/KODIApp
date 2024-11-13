import 'dart:convert';

class TrolleyMakerPartners {
  final String gguid;
  final String companyName;
  final String street;
  final String zip;
  final String city;
  final List<String> categories;
  final String logoUrl;
  final bool bonusActive;

  TrolleyMakerPartners({
    required this.gguid,
    required this.companyName,
    required this.street,
    required this.zip,
    required this.city,
    required this.categories,
    required this.logoUrl,
    required this.bonusActive,
  });

  // Factory method to create an instance of TrolleyMakerPartnersResponse from JSON
  factory TrolleyMakerPartners.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerPartners(
      gguid: json['gguid'],
      companyName: json['companyName'],
      street: json['street'],
      zip: json['zip'],
      city: json['city'],
      categories: List<String>.from(json['categories']),
      logoUrl: json['logoUrl'],
      bonusActive: json['bonusActive'],
    );
  }

  // Method to convert a TrolleyMakerPartnersResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'gguid': gguid,
      'companyName': companyName,
      'street': street,
      'zip': zip,
      'city': city,
      'categories': categories,
      'logoUrl': logoUrl,
      'bonusActive': bonusActive,
    };
  }
}

// Function to parse a list of TrolleyMakerPartnersResponse objects from JSON
List<TrolleyMakerPartners> parseTrolleyMakerPartnersResponses(String jsonStr) {
  final List<dynamic> parsedList = json.decode(jsonStr);
  return parsedList.map((json) => TrolleyMakerPartners.fromJson(json)).toList();
}
