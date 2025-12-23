class WasteLocation {
  final int id;
  final String name;
  final String hashedStreetName;

  WasteLocation({
    required this.id,
    required this.name,
    required this.hashedStreetName,
  });

  factory WasteLocation.fromJson(Map<String, dynamic> json) {
    return WasteLocation(
      id: json['id'],
      name: json['name'],
      hashedStreetName: json['hashedStreetName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hashedStreetName': hashedStreetName,
    };
  }
}
