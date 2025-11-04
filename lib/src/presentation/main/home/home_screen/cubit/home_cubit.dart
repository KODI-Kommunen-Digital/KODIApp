import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  dynamic category;
  dynamic location;
  dynamic recent;
  dynamic sliders;
  dynamic categoryCount;
  bool calledExternally = false;
  bool doesScroll = false;
  String searchTerm = "";
  bool isSearching = false;

  Future<void> loadMoreListings() async {
    final currentState = state;
    if (currentState is HomeStateLoaded && !currentState.isLoadingMore) {
      try {
        // Emit loading more state
        emit(currentState.copyWith(isLoadingMore: true));

        if (!await hasInternet()) {
          emit(const HomeState.error("no_internet"));
          return;
        }

        final nextPage = currentState.currentPage + 1;
        List<ProductModel> newListings;

        if (isSearching) {
          newListings = await _searchListingsInternal(searchTerm, nextPage);
        } else {
          newListings = await _fetchRecentListings(nextPage);
        }

        // Combine existing and new listings
        final updatedRecent = List<ProductModel>.from(currentState.recent)..addAll(newListings);

        emit(currentState.copyWith(
          recent: updatedRecent,
          isLoadingMore: false,
          currentPage: nextPage,
        ));
      } catch (error, stackTrace) {
        logError('Error loading more listings: $error');
        await Sentry.captureException(error, stackTrace: stackTrace);
        // Revert to previous state without loading more indicator
        if (currentState is HomeStateLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      }
    }
  }

  Future<void> performSearch(String query) async {
    final currentState = state;
    if (currentState is HomeStateLoaded) {
      try {
        emit(currentState.copyWith(isLoadingMore: true));

        if (!await hasInternet()) {
          emit(const HomeState.error("no_internet"));
          return;
        }

        searchTerm = query;
        isSearching = query.isNotEmpty;

        final searchResults = await _searchListingsInternal(query, 1);

        emit(currentState.copyWith(
          recent: searchResults,
          isLoadingMore: false,
          currentPage: 1,
        ));
      } catch (error, stackTrace) {
        logError('Error searching listings: $error');
        await Sentry.captureException(error, stackTrace: stackTrace);
        if (currentState is HomeStateLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      }
    }
  }

  Future<void> clearSearch() async {
    final currentState = state;
    if (currentState is HomeStateLoaded) {
      try {
        emit(currentState.copyWith(isLoadingMore: true));

        searchTerm = "";
        isSearching = false;

        // Reload initial listings
        await onLoad(false);

      } catch (error, stackTrace) {
        logError('Error clearing search: $error');
        await Sentry.captureException(error, stackTrace: stackTrace);
        if (currentState is HomeStateLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      }
    }
  }

// Helper methods
  Future<List<ProductModel>> _fetchRecentListings(int pageNo) async {
    CategoryModel? savedCity = await checkSavedCity(location);

    if (savedCity != null) {
      final listingsRequestResponse = await Api.requestLocList(savedCity.id, pageNo);
      return List.from(listingsRequestResponse.data ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    } else {
      final listingsRequestResponse = await Api.requestRecentListings(pageNo);
      return List.from(listingsRequestResponse.data ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
  }

  Future<List<ProductModel>> _searchListingsInternal(String content, int pageNo) async {
    int currentCityFilter = await getCurrentCityFilter();
    MultiFilter multiFilter = MultiFilter(
      hasLocationFilter: false,
      currentLocation: currentCityFilter,
    );

    final result = await ListRepository.searchListing(
      content: content,
      multiFilter: multiFilter,
      pageNo: pageNo,
    );

    final List<ProductModel>? listUpdated = result?[0];
    return listUpdated ?? [];
  }

  HomeCubit() : super(const HomeState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    int maxId = location.isNotEmpty
        ? location.map((e) => e.id).reduce((a, b) => a > b ? a : b)
        : 0;

    location.add(CategoryModel(
      id: ++maxId,
      title: 'Pressig',
      image: 'admin/City2.png',
    ));
    location.add(CategoryModel(
      id: ++maxId,
      title: 'Schneckenlohe',
      image: 'admin/City3.png',
    ));
    location.add(CategoryModel(
      id: ++maxId,
      title: 'Mitwitz',
      image: 'admin/City1.png',
    ));
    if (!calledExternally && !isRefreshLoader) {
      await AppBloc.discoveryCubit.onLoad();
    }

    if (!isRefreshLoader) {
      emit(HomeState.categoryLoading(location));
    }

    final categoryRequestResponse = await Api.requestHomeCategory();
    category = List.from(categoryRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    CategoryModel? savedCity = await checkSavedCity(location);
    if (savedCity != null) {
      final listingsRequestResponse = await Api.requestLocList(savedCity.id, 1);
      recent = List.from(listingsRequestResponse.data ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    } else {
      final listingsRequestResponse = await Api.requestRecentListings(1);
      recent = List.from(listingsRequestResponse.data ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    final categoryCountRequestResponse =
        await Api.requestCategoryCount(savedCity?.id);
    categoryCount =
        List.from(categoryCountRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    const banner = Images.slider;

    List<CategoryModel> formattedCategories =
        await formatCategoriesList(category, categoryCount, savedCity?.id);

    emit(HomeStateLoaded(
      banner: banner,
      category: formattedCategories,
      location: location,
      recent: recent,
      isRefreshLoader: isRefreshLoader,
      isLoadingMore: false,
    ));
  }

  Future<void> saveIgnoreAppVersion(String version) async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(Preferences.ignoredAppVersion, version);
  }

  // Future<void> fetchNewListings(int page) async {
  //   emit(HomeLoading());
  //   try {
  //     final listings = await repository.getListings(page);
  //     emit(HomeLoaded(listings: listings, page: page));
  //   } catch (e, s) {
  //     await Sentry.captureException(e, stackTrace: s);
  //     emit(HomeError(e.toString()));
  //   }
  // }

  Future<String> getIgnoreAppVersion() async {
    final prefs = await Preferences.openBox();
    String ignoreVersion =
        await prefs.getKeyValue(Preferences.ignoredAppVersion, '');
    return ignoreVersion;
  }

  Future<bool> doesUserExist() async {
    final int userId = await UserRepository.getLoggedUserId();
    if (userId == 0) return true;

    bool doesExist = await UserRepository.doesUserExist(userId);
    return doesExist;
  }

  String getCityName(List<CategoryModel>? cities, int cityId) {
    if (cities != null) {
      String name =
          cities[cities.indexWhere((category) => category.id == cityId)].title;
      return name;
    }
    return "";
  }

  Future<bool> categoryHasContent(int id, int? cityId) async {
    final response =
        await Api.requestCategoryCount(cityId == 0 ? null : cityId);
    final list = List.from(response.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    if (list.any((element) => element.id == id) ||
        (cityId == 0 && list.isNotEmpty)) {
      return true;
    }
    return false;
  }

  void scrollUp() {
    emit(const HomeStateLoading());
    const banner = Images.slider;
    emit(HomeStateLoaded(
      banner: banner,
      category: category,
      location: location,
      recent: recent,
      isRefreshLoader: false,
      isLoadingMore: false,
    ));
  }

  bool getCalledExternally() {
    return calledExternally;
  }

  void setCalledExternally(bool called) {
    calledExternally = called;
  }

  bool getDoesScroll() {
    return doesScroll;
  }

  void setDoesScroll(bool scroll) {
    doesScroll = scroll;
  }

  Future<List<CategoryModel>> formatCategoriesList(
    List<CategoryModel> categories,
    List<CategoryModel> categoryCount,
    int? cityId,
  ) async {
    // Sort List
    // Map<int, int?> idToCountMap = {};
    // for (var obj in categoryCount) {
    //   idToCountMap[obj.id] = obj.count;
    // }
    // categories.sort((a, b) {
    //   if (a.id == 17) return 1; // Move category with id 14 to the last index
    //   if (b.id == 17) return -1;

    //   return (idToCountMap[b.id] ?? 0).compareTo(idToCountMap[a.id] ?? 0);
    // });

    //Forum always at index 6, before the more button
    int forumIndex = categories.indexWhere((element) => element.id == 17);

    if (forumIndex != -1) {
      var forum = categories.removeAt(forumIndex);
      categories.insert(6, forum);
    }
    // Hide tag on empty categories
    for (var element in categories) {
      // bool hasContent = await categoryHasContent(element.id, cityId);
      // if (!hasContent) {
      //   element.hide = true;
      // }
      if (element.id == 17 || element.id == 100) {
        element.hide = false;
      }
    }

    return categories;
  }

  Future<void> saveCityId(int cityId) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.cityId, cityId);
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('dns.google');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  List<CategoryModel> getCategoriesWithoutHidden(
      List<CategoryModel> categoryList) {
    List<CategoryModel> noHiddenCategoryList = [];
    for (var element in categoryList) {
      if (!element.hide) {
        noHiddenCategoryList.add(element);
      }
    }
    return noHiddenCategoryList;
  }

  Future<CategoryModel?> checkSavedCity(List<CategoryModel> cities) async {
    final prefs = await Preferences.openBox();
    final cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    if (cityId != 0) {
      final cityName =
          cities[cities.indexWhere((category) => category.id == cityId)].title;
      return CategoryModel(id: cityId, title: cityName, image: "");
    }
    return null;
  }

  Future<dynamic> newListings(int pageNo) async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }

    final listingsRequestResponse = await Api.requestRecentListings(pageNo);
    final newRecent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();
    recent.addAll(newRecent);
    return recent;
  }

  Future<List<ProductModel>> searchListing(content, int pageNo) async {
    int currentCityFilter = await getCurrentCityFilter();
    List<ProductModel>? listDataList = [];
    MultiFilter multiFilter = MultiFilter(
        hasLocationFilter: false, currentLocation: currentCityFilter);

    final result = await ListRepository.searchListing(
        content: content, multiFilter: multiFilter, pageNo: pageNo);
    final List<ProductModel>? listUpdated = result?[0];

    if (listUpdated != null) {
      if (pageNo == 1) {
        recent = [];
      }
      recent.addAll(listUpdated);
    }

    for (final product in recent) {
      if (product != null) {
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
    }

    return listDataList;
  }

  Future<int> getCurrentCityFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.allListingCityFilter, 0);
    return filter;
  }
}
