class StoreModel {
  final int id;
  final String name;
  final String description;
  final String? address;
  final String? latitude;
  final String? longitude;

  StoreModel(
      {required this.id,
      required this.name,
      required this.description,
      this.address,
      this.latitude,
      this.longitude});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        address: json['address'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}
