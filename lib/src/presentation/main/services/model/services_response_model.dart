class ServiceResponseModel {
  String bgImg; // background image
  String name;
  String? navigationUrl;
  ServiceType type;

  ServiceResponseModel(
    this.bgImg,
    this.name,
    this.type, {
    this.navigationUrl,
  });

  /// Convert int -> enum
  static ServiceType _fromIntToServiceType(int? value) {
    switch (value) {
      case 1:
        return ServiceType.navigation;
      case 2:
        return ServiceType.contact;
      default:
        return ServiceType.unknown;
    }
  }

  /// Convert enum -> int
  static int _fromServiceTypeToInt(ServiceType type) {
    switch (type) {
      case ServiceType.navigation:
        return 1;
      case ServiceType.contact:
        return 2;
      case ServiceType.unknown:
      default:
        return 0;
    }
  }

  // Named constructor for creating an object from JSON
  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      json['bgImg'] ?? '',
      json['name'] ?? '',
      _fromIntToServiceType(json['type']),
      navigationUrl: json['navigationUrl'],
    );
  }

  // Method to convert an object into JSON
  Map<String, dynamic> toJson() {
    return {
      'bgImg': bgImg,
      'name': name,
      'navigationUrl': navigationUrl,
      'type': _fromServiceTypeToInt(type),
    };
  }
}

enum ServiceType {
  navigation, // 1
  contact, // 2
  unknown, // fallback
}

// Mock data for ServiceResponseModel
final List<ServiceResponseModel> services = [
  ServiceResponseModel(
    "assets/images/services/ser1.jpeg",
    "Wirtschaftsstandort Fichtelgebirge",
    navigationUrl:
        "https://freiraum-fichtelgebirge.de/freiraum-fuer-unternehmen/wirtschaftsstandort-fichtelgebirge/",
    ServiceType.navigation,
  ),
  ServiceResponseModel(
    "assets/images/services/ser2.jpeg",
    "Gründung & Start-Ups",
    navigationUrl:
        "https://freiraum-fichtelgebirge.de/freiraum-fuer-unternehmen/start-ups/",
    ServiceType.navigation,
  ),
  ServiceResponseModel(
    "assets/images/services/ser3.jpeg",
    "Finanzierung & Förderungen",
    navigationUrl:
        "https://freiraum-fichtelgebirge.de/freiraum-fuer-unternehmen-2/finanzierung/",
    ServiceType.navigation,
  ),
  ServiceResponseModel(
    "assets/images/services/ser4.jpeg",
    "Unternehmensverzeichnis",
    navigationUrl:
        "https://freiraum-fichtelgebirge.de/unternehmensverzeichnis/",
    ServiceType.navigation,
  ),
  ServiceResponseModel(
    "assets/images/services/ser5.jpeg",
    "Energie- & Macher-Region",
    navigationUrl:
        "https://freiraum-fichtelgebirge.de/energie-und-macherregion-fichtelgebirge/",
    ServiceType.navigation,
  ),
  ServiceResponseModel(
    "assets/images/services/ser6.jpeg",
    "Kontakt",
    ServiceType.contact,
  ),
];
