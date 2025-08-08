import 'package:heidi/src/data/repository/list_repository.dart';

class CitizenServiceModel {
  final String title;
  final String imageUrl;
  final String imageLink;
  final String type;
  final int? categoryId;
  final int? arguments;
  final int? subCategoryId;
  final List<CitizenServiceModel>? subServices;

  CitizenServiceModel({
    required this.title,
    required this.imageUrl,
    required this.imageLink,
    this.type = "categoryService",
    this.categoryId,
    this.arguments,
    this.subCategoryId,
    this.subServices,
  });

  Future<bool> hasContent() async {
    final result = await ListRepository.loadList(
      categoryId: categoryId,
      type: type,
      pageNo: 1,
      subCategoryId: subCategoryId,
    );
    return !result?[0].isEmpty;
  }
}
