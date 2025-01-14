import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'cubit.dart';

enum ProductFilter {
  week,
  month,
}

class ListCubit extends Cubit<ListState> {
  final ListRepository repo;

  ListCubit(this.repo) : super(const ListStateLoading()) {
    // final isEvent = categoryPreferencesCall();
  }

  int pageNo = 1;
  List<ProductModel> list = [];
  PaginationModel? pagination;
  List<ProductModel> listLoaded = [];
  List<ProductModel> filteredList = [];
  List listCity = [];
  bool isSearching = false;
  String? searchTerm;

  Future<void> onLoad(cityId, int? subCategoryId) async {
    print("fetchibng data onLoad");
    pageNo = 1;
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final type = await prefs.getKeyValue(Preferences.type, '');
    listCity = await getCityList() ?? [];
    dynamic result;
    if (cityId is List) {
      print("fetchibng data multiple city");
      result = [];
      for (var city in cityId) {
        final list = await ListRepository.loadList(
          categoryId: (categoryId == 0) ? "" : categoryId,
          type: type,
          pageNo: pageNo,
          cityId: city,
          subCategoryId: subCategoryId,
        );
        result.addAll(list);
      }
    } else {
      print("fetchibng data single city");
      result = await ListRepository.loadList(
        categoryId: (categoryId == 0) ? "" : categoryId,
        type: type,
        pageNo: pageNo,
        cityId: cityId,
        subCategoryId: subCategoryId,
      );
    }
    if (result != null) {
      list = result[0];
      pagination = result[1];
      listLoaded = list;
      emit(ListStateLoaded(list, listCity));
    }
  }

  Future<void> setCategoryFilter(
      int filter, int? cityId, int? subCategoryId) async {
    final prefs = await Preferences.openBox();

    if (filter == 0) {
      prefs.setKeyValue(Preferences.categoryId, 0);
    } else {
      prefs.setKeyValue(Preferences.categoryId, filter);
    }
    if (cityId != null) {
      print("fetchibng data 3");
      onLoad(cityId, subCategoryId);
    }
  }

  Future<int?> getCategoryId() async {
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, null);
    return categoryId;
  }

  Future<void> setCategoryId(int categoryId) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.categoryId, categoryId);
  }

  Future<List<ProductModel>> newListings(
      int pageNo, city, int? subCategoryId) async {
    final prefs = await Preferences.openBox();
    // final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final type = prefs.getKeyValue(Preferences.type, '');

    dynamic result;

    if (city is List) {
      result = [];
      for (var cityId in city) {
        print("fetchibng data mul city new listing");
        final list = await ListRepository.loadList(
          categoryId: (categoryId == 0) ? "" : categoryId,
          type: type,
          pageNo: pageNo,
          cityId: cityId,
          subCategoryId: subCategoryId,
        );
        result.addAll(list);
      }
    } else {
      print("fetchibng single city new listing");
      result = await ListRepository.loadList(
        categoryId: (categoryId == 0) ? "" : categoryId,
        type: type,
        pageNo: pageNo,
        cityId: city,
        subCategoryId: subCategoryId,
      );
    }

    final listUpdated = result?[0] ?? [];
    if (listUpdated.isNotEmpty) {
      list.addAll(listUpdated);
    }
    return list;
  }

  List<ProductModel> getLoadedList() => listLoaded;

  Future<List<ProductModel>> updateLoadedList(city, int? subCategoryId) async {
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final type = prefs.getKeyValue(Preferences.type, '');
    List<ProductModel> result = [];
    for (var cityId in city) {
      print("fetchibng data updated loaded list 1");
      final list = await ListRepository.loadList(
        categoryId: (categoryId == 0) ? "" : categoryId,
        type: type,
        pageNo: pageNo,
        cityId: cityId,
        subCategoryId: subCategoryId,
      );
      result.addAll(list?[0] as List<ProductModel>? ?? []);
    }
    listLoaded = result;
    return listLoaded;
  }

  Future<void> searchListing(
      content, bool newSearch, int? subCategoryId) async {
    if (newSearch) {
      emit(const ListState.loading());
      pageNo = 1;
    }
    isSearching = true;
    searchTerm = content.toString();
    final prefs = await Preferences.openBox();

    final categoryId = prefs.getKeyValue(Preferences.categoryId, 0);
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    List<ProductModel>? listDataList = [];
    MultiFilter multiFilter = MultiFilter(
        hasCategoryFilter: true,
        hasLocationFilter: true,
        currentLocation: cityId,
        currentCategory: categoryId,
        hasSubCategoryFilter: true,
        currentSubCategory: subCategoryId);

    final result = await ListRepository.searchListing(
        content: content, multiFilter: multiFilter, pageNo: pageNo++);
    final List<ProductModel>? listUpdated = result?[0];
    if (listUpdated != null) {
      if (newSearch) {
        list = [];
      }
      list.addAll(listUpdated);
    }
    for (final product in list) {
      listDataList.add(
        ProductModel(
          id: product.id,
          cityId: product.cityId,
          title: product.title,
          image: product.image,
          pdf: product.pdf,
          category: product.category,
          categoryId: product.categoryId,
          subcategoryId: product.subcategoryId,
          startDate: product.startDate,
          endDate: product.endDate,
          createDate: product.createDate,
          favorite: product.favorite,
          address: product.address,
          phone: product.phone,
          email: product.email,
          website: product.website,
          description: product.description,
          statusId: product.statusId,
          userId: product.userId,
          sourceId: product.sourceId,
          imageLists: product.imageLists,
          externalId: product.externalId,
          expiryDate: product.expiryDate,
        ),
      );
    }

    emit(ListStateUpdated(listDataList, listCity));
  }

  Future<void> cancelSearch(int cityId, int? subCategoryId) async {
    isSearching = true;
    searchTerm = "";
    pageNo = 0;
    print("fetchibng data 4");
    onLoad(cityId, subCategoryId);
  }

  void onDateProductFilter(ProductFilter? type, List<ProductModel> loadedList,
      bool filterLocation, List<int>? currentCity) {
    final currentDate = DateTime.now();
    if (type == ProductFilter.month) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startMonth = startDate.month;
          final currentMonth = currentDate.month;
          if (filterLocation && (currentCity ?? []).isNotEmpty) {
            return (startMonth == currentMonth) &&
                (currentCity!.contains(product.cityId));
          } else {
            return startMonth == currentMonth;
          }
        }
        return false;
      }).toList();

      emit(ListStateUpdated(filteredList, listCity));
    } else if (type == ProductFilter.week) {
      filteredList = loadedList.where((product) {
        final startDate = _parseDate(product.startDate);
        if (startDate != null) {
          final startWeek = _getWeekNumber(startDate);
          final currentWeek = _getWeekNumber(currentDate);
          if (filterLocation && (currentCity ?? []).isNotEmpty) {
            return (startWeek == currentWeek) &&
                (currentCity!.contains(product.cityId));
          } else {
            return startWeek == currentWeek;
          }
        }
        return false;
      }).toList();
      emit(ListStateUpdated(filteredList, listCity));
    } else if (type == null &&
        filterLocation &&
        (currentCity ?? []).isNotEmpty) {
      if ((currentCity ?? []).contains(0)) {
        filteredList = loadedList;
      } else {
        filteredList = loadedList.where((product) {
          return currentCity!.contains(product.cityId);
        }).toList();
      }
      emit(ListStateUpdated(filteredList, listCity));
    } else {
      emit(ListStateUpdated(loadedList, listCity));
    }
  }

  DateTime? _parseDate(String dateTimeString) {
    try {
      final dateAndTimeParts = dateTimeString.split(' ');
      if (dateAndTimeParts.isNotEmpty) {
        final datePart = dateAndTimeParts[0];
        final dateParts = datePart.split('.');
        if (dateParts.length == 3) {
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      logError("Error parsing date: $dateTimeString");
    }
    return null;
  }

  Future<List?> getCityList() async {
    ResultApiModel? loadCitiesResponse;
    try {
      loadCitiesResponse = await repo.loadCities();
    } catch (e, stackTrace) {
      logError('load cities error', e.toString());
      await Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }

    List listCity = loadCitiesResponse.data;
    return listCity;
  }

  String getCityNameFromId(List listCity, int cityId) {
    if (listCity.isNotEmpty) {
      final city = listCity.firstWhere((cityData) => cityData["id"] == cityId);
      return city["name"];
    }
    return "";
  }

  int _getWeekNumber(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final daysSinceStartOfYear = date.difference(startOfYear).inDays;
    return (daysSinceStartOfYear / 7).ceil();
  }

  Future<bool?> categoryPreferencesCall() async {
    final prefs = await Preferences.openBox();
    final categoryId = prefs.getKeyValue(Preferences.categoryId, '');
    if (categoryId == 3) {
      return true;
    } else {
      return null;
    }
  }

  Future<String?> getCategory(int? subCategoryId) async {
    final categoryId = await repo.getCategoryId();
    if (categoryId == 45 && subCategoryId != null) {
      switch (subCategoryId) {
        case 12:
          return "category_handwerk";
        case 13:
          return "category_gesundheit";
        case 14:
          return "category_immobilien";
        case 15:
          return "category_finanzen";
      }
    } else if (categoryId == 46 && subCategoryId != null) {
      switch (subCategoryId) {
        case 20:
          return "category_handel";
        case 19:
          return "category_offers";
      }
    } else if (categoryId == 43 && subCategoryId != null) {
      switch (subCategoryId) {
        case 16:
          return "category_tagesangebote";
        case 17:
          return "categroy_speisekarten";
        case 18:
          return "categroy_lokale";
      }
    }
    Map<int, String> categories = {
      1: "category_news",
      2: "category_traffic",
      3: "category_events",
      4: "category_clubs",
      5: "category_products",
      6: "category_offer_search",
      7: "category_free",
      8: "category_defect_report",
      9: "category_lost_found",
      10: "category_companies",
      11: "category_public_transport",
      12: "category_offers",
      13: "category_food",
      29: "category_handel",
      44: "category_job",
      43: "category_gastro",
    };
    return categories[categoryId];
  }
}
