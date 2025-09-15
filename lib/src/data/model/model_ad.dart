class AdDataModel {
  final String? link;
  final String? image;

  AdDataModel({this.link, this.image});

  factory AdDataModel.fromJson(Map<String, dynamic> json) {
    return AdDataModel(
      link: json['link'] as String?,
      image: json['image'] as String?,
    );
  }
}
