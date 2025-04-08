class ContainerShelfProductModel {
  final int id;
  final double tax;
  final double price;
  final String title;
  final int inventory;
  final String? description;
  final List<String>? productImages;

  ContainerShelfProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.productImages,
    required this.price,
    required this.tax,
    required this.inventory,
  });

  factory ContainerShelfProductModel.fromJson(
      Map<String, dynamic> json, int cityId) {
    return ContainerShelfProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      price: json['price'].toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      inventory: json['inventory'] ?? 0,
        productImages: (json['productImages'] ?? []).cast<String>()
    );
  }
}
