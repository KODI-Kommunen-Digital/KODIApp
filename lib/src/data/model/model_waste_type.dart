class WasteType {
  final int id;
  final String name;
  final String image;
  final String colour;

  WasteType({
    required this.id,
    required this.name,
    required this.image,
    required this.colour,
  });

  factory WasteType.fromJson(Map<String, dynamic> json) {
    return WasteType(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      colour: json['colour'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'colour': colour,
    };
  }
}