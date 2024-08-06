import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_seller.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class ContainerRepository {
  final Preferences prefs;

  ContainerRepository(this.prefs);

  static Future<List<StoreModel>?> loadStores(int cityId, int? pageNo) async {
    final response = await Api.getAllStores(cityId, pageNo);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return StoreModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError('Error loading stores: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<StoreModel>?> loadStoresOwner(int? pageNo) async {
    final response = await Api.getOwnerStores(pageNo);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return StoreModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading onwer stores: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<CategoryModel>?> loadStoreCategories(
      int cityId, int storeId) async {
    final response = await Api.getStoreCategories(cityId, storeId);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading store categories: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<CategoryModel>?> loadStoreSubCategories(
      int cityId, int storeId, int categoryId) async {
    final response =
        await Api.getStoreSubCategories(cityId, storeId, categoryId);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading store categories: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<StoreModel?> loadStore(int cityId, int storeId) async {
    final response = await Api.getStoreDetails(cityId, storeId);
    if (response.success) {
      final storeDetails = StoreModel.fromJson(response.data);
      return storeDetails;
    } else {
      logError('Error loading stores: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<bool> updateStore(
      {required int cityId,
      required int storeId,
      required String name,
      String? address,
      String? latitude,
      String? longitude,
      String? description}) async {
    Map<String, dynamic> params = {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'description': description
    };

    final response = await Api.editStoreDetails(cityId, storeId, params);
    if (response.success) {
      return true;
    } else {
      logError('Error patching store: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<bool> checkIn(int cityId, int storeId) async {
    final response = await Api.checkIn(cityId, storeId);
    if (response.success) {
      return true;
    } else {
      logError('Error checking in: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<bool> checkOut(int cityId, int storeId) async {
    final response = await Api.checkOut(cityId, storeId);
    if (response.success) {
      return true;
    } else {
      logError('Error checking out: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<bool> saveShelf({
    required int cityId,
    required int storeId,
    required String title,
    String? description,
    required int productId,
  }) async {
    Map<String, dynamic> params = {
      'title': title,
      'description': description,
      'productId': productId,
      'shopId': storeId
    };

    final response = await Api.addShelf(cityId, storeId, params);

    if (response.success) {
      return true;
    } else {
      logError('Error saving shelf: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<List<ShelfModel>?> getStoreShelves(
      int cityId, int storeId, int pageNo) async {
    final response = await Api.getShelves(cityId, storeId, pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return ShelfModel.fromJson(item, cityId);
      }).toList();

      return list;
    } else {
      logError('Error loading shelves: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<List<SellerModel>?> getStoreSellers(
      int cityId, int storeId, int pageNo) async {
    final response = await Api.getStoreSellers(
        cityId: cityId, storeId: storeId, pageNo: pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return SellerModel.fromJson(item);
      }).toList();

      return list;
    } else {
      logError('Error loading sellers: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<List<OrderModel>?> getStoreOrders(
      int cityId, int storeId, int pageNo) async {
    final response = await Api.getStoreOrders(cityId, storeId, pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return OrderModel.fromJson(item, cityId);
      }).toList();

      return list;
    } else {
      logError('Error loading orders: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<ShelfModel?> getShelfDetails(
      int cityId, int storeId, int shelfId) async {
    final response = await Api.getShelfDetails(cityId, storeId, shelfId);
    if (response.success) {
      final shelf = ShelfModel.fromJson(response.data, cityId);
      return shelf;
    } else {
      logError('Error loading shelf: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<bool> deleteProduct(int cityId, int storeId, int productId) async {
    final response = await Api.deleteProductStore(
        cityId: cityId, storeId: storeId, productId: productId);

    if (response.success) {
      return true;
    } else {
      logError('Error deleting product: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<bool> editProduct(
      {required int cityId,
      required int storeId,
      required int productId,
      required String title,
      String? description,
      required double price,
      required double tax,
      required int inventory,
      required int minCount,
      required int maxCount,
      String? meta,
      required bool isActive}) async {
    Map<String, dynamic> params = {
      "title": title,
      "description": description,
      "price": price,
      "tax": tax,
      "inventory": inventory,
      "minCount": minCount,
      "maxCount": maxCount,
      "meta": meta,
      "isActive": isActive
    };

    final response =
        await Api.updateProductStore(cityId, storeId, productId, params);

    if (response.success) {
      return true;
    } else {
      logError('Error updating product: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<ContainerProductModel?> getProductDetails(
      int cityId, int storeId, int productId) async {
    final response = await Api.getProductDetails(cityId, storeId, productId);
    if (response.success) {
      final product = ContainerProductModel.fromJson(response.data, cityId);
      return product;
    } else {
      logError('Error loading product: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<OrderModel?> getOrderDetails(
      int cityId, int storeId, int orderId) async {
    final response = await Api.getOrderDetails(cityId, storeId, orderId);
    if (response.success) {
      final order = OrderModel.fromJson(response.data, cityId);
      return order;
    } else {
      logError('Error loading order: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<bool> reportProduct(
      {required int cityId,
      required int storeId,
      required int productId,
      String? title,
      String? description}) async {
    Map<String, String?> params = {'title': title, 'description': description};

    final response =
        await Api.reportProductProblem(cityId, storeId, productId, params);
    if (response.success) {
      return true;
    } else {
      logError('Error posting report: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<List<ProductRequestModel>?> getStoreProductRequests(
      {required int cityId,
      required int storeId,
      required int pageNo,
      int? status,
      int? requestType}) async {
    String statusQuery = "";
    String reqTypeQuery = "";

    if (status != null) {
      statusQuery = "&status=$status";
    }
    if (requestType != null) {
      reqTypeQuery = "&requestType=$requestType";
    }

    final response = await Api.getProductRequests(
        cityId: cityId,
        storeId: storeId,
        pageNo: pageNo,
        status: statusQuery,
        reqType: reqTypeQuery);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return ProductRequestModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error getting product requests: ${response.data} ${response.message}');
      return null;
    }
  }

  Future<ProductRequestModel?> getProductRequestDetails(
      int cityId, int storeId, int requestId) async {
    final response =
        await Api.getProductRequestDetails(cityId, storeId, requestId);

    if (response.success) {
      final request = ProductRequestModel.fromJson(response.data);
      return request;
    } else {
      logError(
          'Error getting product request details: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<bool> addStoreProduct(
      {required int cityId,
      required int storeId,
      required String title,
      required String description,
      required double price,
      required double tax,
      required int inventory,
      required int minCount,
      required int maxCount,
      String? meta}) async {
    Map<String, dynamic> params = {
      "title": title,
      "description": description,
      "price": price,
      "tax": tax,
      "inventory": inventory,
      "minCount": minCount,
      "maxCount": maxCount,
      "meta": meta ?? ''
    };

    final response = await Api.addProduct(cityId, storeId, params);

    if (response.success) {
      return true;
    } else {
      logError('Error posting product: ${response.data} ${response.message}');
      return false;
    }
  }

  Future<List<ContainerProductModel>?> getStoreProducts({
    required int cityId,
    required int storeId,
    required int pageNo,
    int? categoryId,
    int? subCategoryId,
    String? search,
    String? sort,
    bool sortDesc = false,
  }) async {
    List<String> validSort = [
      "price",
      "title",
      "createdAt",
      "updatedAt",
      "quantity",
      "categoryId",
      "subCategoryId"
    ];

    String categoryQuery = "";
    String subCategoryQuery = "";
    String searchQuery = "";
    String sortQuery = "";
    String sortDescQuery = "";

    if (categoryId != null) {
      categoryQuery = "&categoryId=$categoryId";
    }

    if (subCategoryId != null) {
      subCategoryQuery = "&subCategoryId=$subCategoryId";
    }

    if (search != null) {
      searchQuery = "&search=$search";
    }

    if (sort != null && validSort.contains(sort)) {
      sortQuery = "&sort=$sort";
    }

    if (sortDesc == true) {
      sortDescQuery = "&sortDesc=true";
    }

    final response = await Api.getStoreProducts(
        cityId: cityId,
        storeId: storeId,
        pageNo: pageNo,
        category: categoryQuery,
        subCategory: subCategoryQuery,
        search: searchQuery,
        sort: sortQuery,
        sortDesc: sortDescQuery);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return ContainerProductModel.fromJson(item, cityId);
      }).toList();
      return list;
    } else {
      logError('Error getting products: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<CategoryModel?> loadStoreCategory(
      int cityId, int storeId, int categoryId) async {
    final response = await Api.getStoreCategory(cityId, storeId, categoryId);
    if (response.success) {
      final category = CategoryModel.fromJson(response.data);
      return category;
    } else {
      logError('Error loading category: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<CategoryModel?> loadStoreSubCategory(
      int cityId, int storeId, int subCategoryId) async {
    final response =
        await Api.getStoreSubCategory(cityId, storeId, subCategoryId);
    if (response.success) {
      final subCategory = CategoryModel.fromJson(response.data);
      return subCategory;
    } else {
      logError(
          'Error loading subCategory: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<Map<String, bool>> getUserPermission(int userId) async {
    final response = await Api.getUserContainerPermission(userId);

    Map<String, bool> permissions = {
      'Owner': false,
      'Seller': false,
      'Customer': false
    };

    if (response.success) {
      for (var permission in response.data) {
        if (permission == "0" || permission == "1") {
          permissions['Customer'] = true;
        } else if (permission == "102") {
          permissions['Seller'] = true;
        } else if (permission == "101") {
          permissions['Owner'] = true;
        }
      }
    } else {
      logError(
          'Error loading user permissions: ${response.data} ${response.message}');
    }
    return permissions;
  }

  static Future<List<SellerOrderModel>?> getSellerOrders(pageNo) async {
    final response = await Api.getSellerSoldOrders(pageNo);

    if(response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return SellerOrderModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError('Error loading seller orders: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<bool> requestBecomeSeller(
      int storeId, String title, String description) async {
    Map<String, dynamic> params = {
      "shopId": storeId,
      "title": title,
      "description": description
    };
    final response = await Api.requestBecomeSeller(params);

    if (response.success) {
      return true;
    } else {
      logError('Error sending request: ${response.data} ${response.message}');
      return false;
    }
  }
}
