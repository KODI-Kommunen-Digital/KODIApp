import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/all_listings/cubit/all_listings_state.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

enum StatusFilter {
  week,
  month,
}

class AllListingsCubit extends Cubit<AllListingsState> {
  AllListingsCubit() : super(const AllListingsState.loading()) {
    onLoad(false);
  }

  dynamic posts;
  StatusFilter? selectedStatusFilter;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const AllListingsState.loading());
    int status = await getCurrentStatus();
    final ResultApiModel listingsRequestResponse;
    int currentCityFilter = await getCurrentCityFilter();

    if (status == 0 && currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestAllListings(1);
    } else if (status != 0 && currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestStatusListings(status, 1);
    } else if (status != 0 && currentCityFilter != 0) {
      listingsRequestResponse =
          await Api.requestStatusLocList(currentCityFilter, 1, status);
    } else {
      listingsRequestResponse = await Api.requestLocList(currentCityFilter, 1,null);
    }

    List<ProductModel> productData =
        List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    List<ProductModel> listDataList = await loadFullProducts(productData) ?? [];

    posts = listDataList;

    int currentListingFilter = await getCurrentStatus();
    emit(AllListingsState.loaded(
        posts, currentListingFilter, currentCityFilter));
  }

  Future<List<ProductModel>?> loadFullProducts(
      List<ProductModel> productData) async {
    List<ProductModel> listDataList = [];
    List<CategoryModel?> location = [];
    final cityRequestResponse = await Api.requestCities();
    if (cityRequestResponse.data != null && cityRequestResponse.data is List) {
      location = List.from(cityRequestResponse.data ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
    }

    for (final listing in productData) {
      final product = await loadProduct(listing.cityId, listing.id);
      if (product != null) {
        String? subcategoryName;
        CategoryModel? city;

        if (listing.categoryId != null &&
            listing.subcategoryId != null &&
            listing.subcategoryId != 0) {
          subcategoryName = await getSubcategoryTranslation(
              listing.categoryId!, listing.subcategoryId!);
        }

        if (listing.cityId != null) {
          city = location.firstWhere((item) => item?.id == listing.cityId);
        } else {
          city = location
              .firstWhere((item) => item?.id == listing.allCities?.first);
        }
        listDataList.add(
          ProductModel(
              id: listing.id,
              cityId: listing.cityId,
              city: city,
              title: product.title,
              image: product.image,
              pdf: product.pdf,
              category: product.category,
              categoryId: product.categoryId,
              subcategory: subcategoryName,
              subcategoryId: product.subcategoryId,
              startDate: product.startDate,
              endDate: product.endDate,
              createDate: product.createDate,
              favorite: product.favorite,
              address: product.address,
              phone: product.phone,
              email: product.email,
              website: product.website,
              externalId: product.externalId,
              description: product.description,
              statusId: product.statusId,
              userId: product.userId,
              sourceId: product.sourceId,
              imageLists: product.imageLists,
              expiryDate: product.expiryDate,
              allCities: product.allCities),
        );
      }
    }
    return listDataList;
  }

  static Future<String?> getSubcategoryTranslation(
      int categoryId, int subcategoryId) async {
    final subcategories =
        await Api.requestSubmitSubCategory(categoryId: categoryId);
    if (subcategories.data != null) {
      var jsonCategory = subcategories.data;
      final item =
          jsonCategory.firstWhere((item) => item['id'] == subcategoryId);
      final List<String> translations =
          ListCubit.getSubCategories().values.toList();
      String? subcategoryTranslation = translations.firstWhereOrNull(
          (element) => element
              .toLowerCase()
              .trim()
              .contains(item['name'].toString().toLowerCase().trim()));
      return subcategoryTranslation ?? item['name'];
    }
    return null;
  }

  Future<ProductModel?> loadProduct(cityId, id) async {
    final loadProductResponse = await ListRepository.loadProduct(cityId, id);
    return loadProductResponse;
  }

  Future<List<ProductModel>?> searchListing(content, int pageNo) async {
    int currentListingFilter = await getCurrentStatus();
    int currentCityFilter = await getCurrentCityFilter();
    List<ProductModel>? listDataList = [];
    MultiFilter multiFilter = MultiFilter(
        hasLocationFilter: true,
        hasListingStatusFilter: true,
        currentListingStatus: currentListingFilter,
        currentLocation: currentCityFilter);

    final result = await ListRepository.searchListing(
        content: content, multiFilter: multiFilter, pageNo: pageNo);
    final List<ProductModel>? listUpdated = result?[0];

    if (listUpdated != null) {
      if (pageNo == 1) {
        posts = [];
      }
      posts.addAll(listUpdated);
    }

    listDataList = await loadFullProducts(posts.cast<ProductModel>());

    return listDataList;
  }

  Future<dynamic> newListings(int pageNo) async {
    if (pageNo == 1) posts = [];
    final int status = await getCurrentStatus();
    final ResultApiModel listingsRequestResponse;
    List<ProductModel> listDataList = [];
    int currentCityFilter = await getCurrentCityFilter();

    if (status == 0 || currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestAllListings(pageNo);
    } else if (status != 0 && currentCityFilter == 0) {
      listingsRequestResponse = await Api.requestStatusListings(status, pageNo);
    } else if (status != 0 && currentCityFilter != 0) {
      listingsRequestResponse =
          await Api.requestStatusLocList(currentCityFilter, pageNo, status);
    } else {
      listingsRequestResponse =
          await Api.requestLocList(currentCityFilter, pageNo,null);
    }

    final newProductData =
        List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    listDataList = await loadFullProducts(newProductData) ?? [];
    posts.addAll(listDataList);
    return posts;
  }

  Future<bool> deleteUserList(int? cityId, int listingId) async {
    final response = await Api.deleteUserList(cityId, listingId);
    if (response.success) {
      return true;
    } else {
      logError('Remove UserList Response Failed', response.message);
      return false;
    }
  }

  Future<int> getCurrentStatus() async {
    final prefs = await Preferences.openBox();
    int status = await prefs.getKeyValue(Preferences.listingStatusFilter, 0);
    return status;
  }

  Future<void> setCurrentStatus(int status) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.listingStatusFilter, status);
  }

  Future<void> setCurrentCityFilter(int filter) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.allListingCityFilter, filter);
  }

  Future<int> getCurrentCityFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.allListingCityFilter, 0);
    return filter;
  }

  Future<int> getCurrentStatusFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.listingStatusFilter, 0);
    return filter;
  }
}
