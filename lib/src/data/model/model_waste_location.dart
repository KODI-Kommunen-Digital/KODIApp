class WasteLocation {
  final int id;
  final String name;

  WasteLocation({
    required this.id,
    required this.name,
  });

  factory WasteLocation.fromJson(Map<String, dynamic> json) {
    return WasteLocation(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
