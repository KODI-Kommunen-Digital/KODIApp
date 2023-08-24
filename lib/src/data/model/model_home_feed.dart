import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';

class HomeFeed {
  String banner;
  List<CategoryModel> category;
  List<CategoryModel> location;
  List<ProductModel> recent;

  HomeFeed({required this.banner, required this.category, required this.location, required this.recent});
}