class AdDataModel {
  final int id;
  final String image;
  final String link;

  AdDataModel({
    required this.id,
    required this.image,
    required this.link,
  });

  AdDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        link = json['link'];
}
