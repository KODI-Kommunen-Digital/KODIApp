import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_cart_item.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_card.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_container_transaction.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_seller.dart';
import 'package:heidi/src/data/model/model_seller_request.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/seller_order_screen.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class ContainerRepository {
  final Preferences prefs;

  ContainerRepository(this.prefs);

  static Future<List<StoreModel>?> loadStores(int cityId, int? pageNo) async {
    final response = await Api.getAllStores(cityId, pageNo);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return StoreModel.fromJson(item, cityId: cityId);
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
          'Error loading owner stores: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<StoreModel>?> loadStoresSeller(int? pageNo) async {
    final response = await Api.getSellerStores(pageNo);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return StoreModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading seller stores: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<CategoryModel>?> loadStoreCategories(
      int cityId, int storeId,
      {int? pageNo}) async {
    final response = await Api.getStoreCategories(cityId, storeId, pageNo);
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

  static Future<List<CategoryModel>?> loadCategoriesGlobal(int pageNo) async {
    final response = await Api.getCategoriesGlobal(pageNo);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading Categories: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<CategoryModel>?> loadSubCategoriesGlobal(
      int categoryId, int pageNo) async {
    final response = await Api.getSubCategoriesGlobal(categoryId, pageNo);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading subCategories: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<StoreModel?> loadStore(int cityId, int storeId) async {
    final response = await Api.getStoreDetails(cityId, storeId);
    if (response.success) {
      final storeDetails = StoreModel.fromJson(response.data, cityId: cityId);
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
      'description': description
    };

    if (longitude != null) {
      params['longitude'] = double.parse(longitude);
    }

    if (latitude != null) {
      params['latitude'] = double.parse(latitude);
    }

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

  static Future<bool> saveShelf({
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

  static Future<List<ShelfModel>?> getStoreShelves(
      int cityId, int storeId, int? pageNo,
      {bool loading = false}) async {
    final response = await Api.getShelves(cityId, storeId, pageNo, loading);

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

  static Future<List<ShelfModel>?> getEmptyStoreShelves(int cityId, int storeId,
      {bool loading = true}) async {
    final response = await Api.getEmptyShelves(cityId, storeId, loading);

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

  static Future<List<SellerModel>?> getStoreSellers(
      int cityId, int storeId, int pageNo) async {
    final response = await Api.getStoreSellers(
        cityId: cityId, storeId: storeId, pageNo: pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return SellerModel.fromJson(item);
      }).toList();

      List<SellerModel> updatedList = [];

      for (var seller in list) {
        final user = await UserRepository.fetchUser(seller.userId);
        if (user != null) {
          updatedList.add(SellerModel.updateUser(seller, user));
        }
      }

      return updatedList;
    } else {
      logError('Error loading sellers: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<OrderModel>?> getStoreOrders(
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

  static Future<bool> deleteProduct(
      int cityId, int storeId, int productId) async {
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
      required ContainerProductModel localProduct,
      required bool isActive,
      required String barcode,
      File? image,
      bool isImageChanged = false}) async {
    Map<String, dynamic> params = {};

    if (title != localProduct.title) {
      params['title'] = title;
    }

    if (description != localProduct.description) {
      params['description'] = description;
    }

    if (price != localProduct.price) {
      params['price'] = price;
    }

    if (tax != localProduct.tax) {
      params['tax'] = tax;
    }

    if (barcode != localProduct.barcode) {
      params['barcode'] = barcode;
    }

    if (inventory != 0) {
      params['inventory'] = inventory;
    }

    if (minCount != localProduct.minCount) {
      params['minCount'] = minCount;
    }

    if (isActive != localProduct.isActive) {
      params['isActive'] = isActive;
    }

    final response =
        await Api.updateProductStore(cityId, storeId, productId, params);

    if (response.success) {
      final prefs = await Preferences.openBox();
      FormData? pickedFile = prefs.getPickedFile();
      var formData = FormData();

      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        if (image != null) {
          var file = image;
          var fileExtension = file.path.split('.').last.toLowerCase();
          var fileName = '$image.$fileExtension';

          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          ));
          final result = await Api.requestContainerProductUploadMedia(
              productId, cityId, storeId, formData);
          logError(result?.message);
        }
      }
      prefs.deleteKey('pickedFile');
      return true;
    } else {
      logError('Error updating product: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<ContainerProductModel?> getProductDetails(
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

  static Future<OrderModel?> getOrderDetails(
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

  static Future<List<ProductRequestModel>?> getStoreProductRequests(
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

  static Future<List<SellerRequestModel>?> getSellerRequests(int pageNo) async {
    final response = await Api.getSellerRequests(pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return SellerRequestModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error getting seller requests: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<SellerRequestModel>?> getSellerRequestsOwner(
      int pageNo, int cityId, int storeId) async {
    final response = await Api.getSellersOwner(pageNo, cityId, storeId, 0);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return SellerRequestModel.fromJson(item);
      }).toList();

      return list;
    } else {
      logError(
          'Error getting seller requests: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<SellerModel>?> getSellersOwner(
      int pageNo, int cityId, int storeId, int status) async {
    final response = await Api.getSellersOwner(pageNo, cityId, storeId, status);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return SellerModel.fromJson(item);
      }).toList();

      return list;
    } else {
      logError('Error getting seller: ${response.data} ${response.message}');
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
      required int categoryId,
      required int? subCategoryId,
      required String barcode,
      File? image,
      bool isImageChanged = false}) async {
    Map<String, dynamic> params = {
      "title": title,
      "description": description,
      "price": price,
      "tax": tax,
      "inventory": inventory,
      "minCount": minCount,
      "categoryId": categoryId,
      "barcode": barcode
    };

    if(subCategoryId != null) {
      params["subCategoryId"] = subCategoryId;
    }

    final response = await Api.addProduct(cityId, storeId, params);

    if (response.success) {
      final prefs = await Preferences.openBox();
      FormData? pickedFile = prefs.getPickedFile();
      var formData = FormData();
      final productId = response.data['id'];

      if (pickedFile != null && pickedFile.files.isNotEmpty) {
        if (image != null) {
          var file = image;
          var fileExtension = file.path.split('.').last.toLowerCase();
          var fileName = '$image.$fileExtension';

          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          ));
          final result = await Api.requestContainerProductUploadMedia(
              productId, cityId, storeId, formData);
          logError(result?.message);
        }
      }
      prefs.deleteKey('pickedFile');
      return true;
    } else {
      logError('Error posting product: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<List<ContainerProductModel>?> getStoreProducts({
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

  static Future<List<ContainerProductModel>?> getSellerProducts({
    required int storeId,
    required int pageNo,
    required int cityId,
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

    final response = await Api.getSellerProducts(
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

  static Future<bool> removeProductFromShelf(int shelfId) async {
    final response = await Api.removeShelfProduct(shelfId);
    if (response.success) {
      return true;
    } else {
      logError('Error removing product: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<bool> acceptProductRequest(
      ProductRequestModel request, List<int> shelfIds, int maxCount) async {
    final params = {
      'storeId': request.shopId,
      'statusId': 1,
      'shelfIds': shelfIds,
      'maxCount': maxCount
    };
    final response = await Api.patchProductRequest(request.id, params);
    if (response.success) {
      return true;
    } else {
      logError(
          'Error accepting product request: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<bool> declineProductRequest(ProductRequestModel request) async {
    final params = {
      'storeId': request.shopId,
      'statusId': 2,
    };
    final response = await Api.patchProductRequest(request.id, params);
    if (response.success) {
      return true;
    } else {
      logError(
          'Error accepting product request: ${response.data} ${response.message}');
      return false;
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

  static Future<List<CartItemModel>?> getSellerOrders(
      pageNo, DateFilter period) async {
    final response =
        await Api.getSellerSoldOrders(pageNo, getStringFromDateFilter(period));

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return CartItemModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading seller orders: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<OrderModel>?> getCustomerOrders(userId, pageNo) async {
    final response = await Api.getCustomerOrders(userId, pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return OrderModel.fromJson(item, null);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading customer orders: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<ContainerCardModel>?> getCustomerCards(userId) async {
    final response = await Api.getCustomerCards(userId);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return ContainerCardModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading customer orders: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<List<ContainerTransactionModel>?> getCustomerTransactions(
      userId, cardId, pageNo) async {
    final response = await Api.getCustomerTransactions(userId, cardId, pageNo);

    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return ContainerTransactionModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError(
          'Error loading customer orders: ${response.data} ${response.message}');
      return null;
    }
  }

  static Future<ResultApiModel?> associateCard(userId, cardId, pin) async {
    Map<String, dynamic> params = {"pinCode": pin};
    final response = await Api.associateCard(userId, cardId, params);

    if (response.success) {
      return response;
    } else {
      logError('Error associating card: ${response.data} ${response.message}');
      return response;
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

  static Future<bool> deleteSeller(int sellerId) async {
    final response = await Api.deleteSeller(sellerId);

    if (response.success) {
      return true;
    } else {
      logError('Error deleting seller: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<bool> updateSeller(
      SellerRequestModel seller, int status) async {
    final params = {
      'title': seller.title,
      'description': seller.description,
      'status': status
    };
    final response = await Api.updateSellerRequest(seller.id, params);

    if (response.success) {
      return true;
    } else {
      logError('Error updating seller: ${response.data} ${response.message}');
      return false;
    }
  }

  static Future<ResultApiModel> addCategoryToStore(
      int storeId, int categoryId) async {
    Map<String, int> params = {'storeId': storeId, 'categoryId': categoryId};

    final response = await Api.addCategoryToStore(params);

    if (!response.success) {
      logError(
          'Error adding category to store: ${response.data} ${response.message}');
    }
    return response;
  }

  static Future<ResultApiModel> removeCategoryFromStore(
      int storeId, int categoryId) async {
    Map<String, int> params = {'storeId': storeId, 'categoryId': categoryId};

    final response = await Api.removeCategoryFromStore(params);

    if (!response.success) {
      logError(
          'Error removing category from store: ${response.data} ${response.message}');
    }
    return response;
  }

  static Future<ResultApiModel> addSubCategoryToStore(
      int storeId, int categoryId) async {
    Map<String, int> params = {'storeId': storeId, 'subCategoryId': categoryId};

    final response = await Api.addSubCategoryToStore(params);

    if (!response.success) {
      logError(
          'Error adding subcategory to store: ${response.data} ${response.message}');
    }
    return response;
  }

  static Future<ResultApiModel> removeSubCategoryFromStore(
      int storeId, int categoryId) async {
    Map<String, int> params = {'storeId': storeId, 'subCategoryId': categoryId};

    final response = await Api.removeSubCategoryFromStore(params);

    if (!response.success) {
      logError(
          'Error removing subcategory from store: ${response.data} ${response.message}');
    }
    return response;
  }

  static Future<bool?> doesStoreHaveCategory(
      int cityId, int storeId, int categoryId) async {
    final categories = await loadStoreCategories(cityId, storeId);

    if (categories != null) {
      for (var category in categories) {
        if (category.id == categoryId) {
          return true;
        }
      }
      return false;
    }
    return null;
  }

  static bool isValidBarcode(String barcode) {
    final length = barcode.length;

    switch (length) {
      case 8: // EAN-8
        int check = int.parse(barcode[7]);
        int val = (10 -
                ((int.parse(barcode[1]) +
                        int.parse(barcode[3]) +
                        int.parse(barcode[5]) +
                        (int.parse(barcode[0]) +
                                int.parse(barcode[2]) +
                                int.parse(barcode[4]) +
                                int.parse(barcode[6])) *
                            3) %
                    10)) %
            10;
        return check == val;
      case 10: // ISBN
        int check = int.parse(barcode[9]);
        int sum = 0;
        for (int i = 0; i < 9; i++) {
          sum += int.parse(barcode[i]) * (i + 1);
        }
        int val = sum % 11;
        return val == 10 ? barcode[9].toLowerCase() == 'x' : check == val;
      case 12: // UPC
        int check = int.parse(barcode[11]);
        int val = (10 -
                ((int.parse(barcode[1]) +
                        int.parse(barcode[3]) +
                        int.parse(barcode[5]) +
                        int.parse(barcode[7]) +
                        int.parse(barcode[9]) +
                        (int.parse(barcode[0]) +
                                int.parse(barcode[2]) +
                                int.parse(barcode[4]) +
                                int.parse(barcode[6]) +
                                int.parse(barcode[8]) +
                                int.parse(barcode[10])) *
                            3) %
                    10)) %
            10;
        return check == val;
      case 13: // EAN-13
        int check = int.parse(barcode[12]);
        int val = (10 -
                ((int.parse(barcode[0]) +
                        int.parse(barcode[2]) +
                        int.parse(barcode[4]) +
                        int.parse(barcode[6]) +
                        int.parse(barcode[8]) +
                        int.parse(barcode[10]) +
                        (int.parse(barcode[1]) +
                                int.parse(barcode[3]) +
                                int.parse(barcode[5]) +
                                int.parse(barcode[7]) +
                                int.parse(barcode[9]) +
                                int.parse(barcode[11])) *
                            3) %
                    10)) %
            10;
        return check == val;
      case 14: // EAN-14
        int check = int.parse(barcode[13]);
        int val = (10 -
                ((int.parse(barcode[1]) +
                        int.parse(barcode[3]) +
                        int.parse(barcode[5]) +
                        int.parse(barcode[7]) +
                        int.parse(barcode[9]) +
                        int.parse(barcode[11]) +
                        (int.parse(barcode[0]) +
                                int.parse(barcode[2]) +
                                int.parse(barcode[4]) +
                                int.parse(barcode[6]) +
                                int.parse(barcode[8]) +
                                int.parse(barcode[10]) +
                                int.parse(barcode[12])) *
                            3) %
                    10)) %
            10;
        return check == val;
      default:
        return false;
    }
  }

  static Future<bool> deleteContainerImage(
      int cityId, int storeId, int product, String imageUrl) async {
    Map<String, String> params = {'url': imageUrl};

    final response =
        await Api.removeContainerImage(cityId, storeId, product, params);

    if (!response.success) {
      logError(
          'Error removing image from product: ${response.data} ${response.message}');
    }
    return response.success;
  }

  static String getStringFromDateFilter(DateFilter filter) {
    String datePeriod = '';
    switch (filter) {
      case DateFilter.today:
        datePeriod = 'today';
        break;
      case DateFilter.week:
        datePeriod = 'this-week';
        break;
      case DateFilter.month:
        datePeriod = 'this-month';
        break;
      case DateFilter.year:
        datePeriod = 'this-year';
        break;
    }
    return datePeriod;
  }
}
