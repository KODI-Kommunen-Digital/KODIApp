class WasteType {
  final int id;
  final String name;

  WasteType({required this.id, required this.name});

  factory WasteType.fromJson(Map<String, dynamic> json) {
    return WasteType(
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
