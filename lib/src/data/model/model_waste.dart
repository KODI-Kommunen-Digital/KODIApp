class WasteCollection {
  final DateTime date;
  final String type;
  final String image;
  final String colour;

  WasteCollection({
    required this.date,
    required this.type,
    required this.image,
    required this.colour,
  });

  factory WasteCollection.fromJson(Map<String, dynamic> json) {
    return WasteCollection(
      date: DateTime.parse(json['dateofPickup']),
      type: json['wastetypeName'],
        image: json['image'] ?? 'waste/icon_tonne_restmuell_2.svg',
        colour: json['colour'] ?? '#000000',
    );
  }
}