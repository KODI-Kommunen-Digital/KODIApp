class WasteLocation {
  final int id;
  final String name;
  final String hashStreetName;

  WasteLocation({
    required this.id,
    required this.name,
    required this.hashStreetName
  });

  factory WasteLocation.fromJson(Map<String, dynamic> json) {
    return WasteLocation(
      id: json['id'],
      name: json['name'],
      hashStreetName: json['hashedStreetName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hashStreetName':hashStreetName
    };
  }
}
