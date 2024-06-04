class WasteCollection {
  final DateTime date;
  final String type;

  WasteCollection({
    required this.date,
    required this.type,
  });

  factory WasteCollection.fromJson(Map<String, dynamic> json) {
    return WasteCollection(
      date: DateTime.parse(json['dateofPickup']),
      type: json['wastetypeName'],
    );
  }
}
