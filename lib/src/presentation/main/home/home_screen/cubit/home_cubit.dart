import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_ad.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  dynamic category;
  dynamic location;
  dynamic recent;
  dynamic currentEvents;
  dynamic sliders;
  dynamic categoryCount;
  dynamic selectedCity;
  bool calledExternally = false;
  bool doesScroll = false;
  bool _isLoading = false;
  int _adIndex = 0;

  HomeCubit() : super(const HomeState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    try {
      if (!await hasInternet()) {
        emit(const HomeState.error("no_internet"));
        return;
      }

      final cityRequestResponse = await Api.requestCities();

      if (cityRequestResponse.data != null &&
          cityRequestResponse.data is List) {
        List<dynamic> cities = List.from(cityRequestResponse.data);

        cities.sort((a, b) {
          String nameA = (a['name'] ?? '').toString().toLowerCase();
          String nameB = (b['name'] ?? '').toString().toLowerCase();
          return nameA.compareTo(nameB);
        });

        location = cities.map((item) {
          return CategoryModel.fromJson(item);
        }).toList();
      } else {
        emit(const HomeState.error("no_valid_data"));
      }

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

      selectedCity = await checkSavedCity(location);

      if (selectedCity != null) {
        final listingsRequestResponse =
            await Api.requestLocList(selectedCity.id, 1);
        recent = List.from(listingsRequestResponse.data ?? []).map((item) {
          return ProductModel.fromJson(item);
        }).toList();
        final currentEventsRequest = await Api.requestCatList(
            3, selectedCity.id, 1);
        currentEvents = List.from(currentEventsRequest.data ?? []).map((item) {
          return ProductModel.fromJson(item);
        }).toList();
      } else {
        final listingsRequestResponse = await Api.requestRecentListings(1);
        recent = List.from(listingsRequestResponse.data ?? []).map((item) {
          return ProductModel.fromJson(item);
        }).toList();
        final currentEventsRequest =
            await Api.requestCatList(3, 1, 1); //cat: 3; city: 1; pageNo: 1;
        currentEvents = List.from(currentEventsRequest.data ?? []).map((item) {
          return ProductModel.fromJson(item);
        }).toList();
      }

      // Fetch ads
      List<AdDataModel> ads = await ListRepository.fetchAds();

      int currentAdIndex = _adIndex;

      List<dynamic> combinedRecent = [];
      for (int i = 0; i < recent.length; i++) {
        combinedRecent.add(recent[i]);

        if ((i + 1) % 6 == 0 && ads.isNotEmpty) {
          combinedRecent.add(ads[currentAdIndex]);
          currentAdIndex = (currentAdIndex + 1) % ads.length;
        }
      }

      _adIndex = currentAdIndex;

      recent = combinedRecent;

      // final categoryCountRequestResponse =
      //     await Api.requestCategoryCount(selectedCity?.id);
      // categoryCount =
      //     List.from(categoryCountRequestResponse.data ?? []).map((item) {
      //   return CategoryModel.fromJson(item);
      // }).toList();

      const banner = Images.slider;

      // List<CategoryModel> formattedCategories =
      //     await formatCategoriesList(category, categoryCount, selectedCity?.id);

      emit(HomeStateLoaded(banner, category, location, recent, isRefreshLoader,
          selectedCity, currentEvents));
    } catch (e) {
      emit(HomeState.error("Error loading data: ${e.toString()}"));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> saveIgnoreAppVersion(String version) async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(Preferences.ignoredAppVersion, version);
  }

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
    emit(HomeStateLoaded(banner, category, location, recent, false,
        selectedCity, currentEvents));
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
      int? cityId) async {
    // Sort List
    Map<int, int?> idToCountMap = {};
    for (var obj in categoryCount) {
      idToCountMap[obj.id] = obj.count;
    }
    categories.sort((a, b) {
      if (a.id == 14) return 1;
      if (b.id == 14) return -1;

      return (idToCountMap[b.id] ?? 0).compareTo(idToCountMap[a.id] ?? 0);
    });

    //Forum always at index 6, before the more button
    int forumIndex = categories.indexWhere((element) => element.id == 14);

    if (forumIndex != -1) {
      var forum = categories.removeAt(forumIndex);
      categories.insert(6, forum);
    }

    return categories;
  }

  void sendToMatomo(int id, String website) {
    ListRepository.saveEventToMatomo(
        type: MatomoType.ad, name: website, adId: id);
  }

  Future<void> saveCityId(int cityId) async {
    //Dont send to Matomo, because it is already sent in Discovery which is always being called
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
      return;
    }

    final listingsRequestResponse = await Api.requestRecentListings(pageNo);
    final newRecent = List.from(listingsRequestResponse.data ?? []).map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    // Fetch ads
    List<AdDataModel> ads = await ListRepository.fetchAds();

    int currentAdIndex = _adIndex;

    List<dynamic> combinedList = [];
    for (int i = 0; i < newRecent.length; i++) {
      combinedList.add(newRecent[i]);

      if ((i + 1) % 6 == 0 && ads.isNotEmpty) {
        combinedList.add(ads[currentAdIndex]);
        currentAdIndex = (currentAdIndex + 1) % ads.length;
      }
    }

    AppBloc.homeCubit._adIndex = currentAdIndex;

    recent.addAll(combinedList);

    return recent;
  }

  Future<int> getCurrentCityFilter() async {
    final prefs = await Preferences.openBox();
    int filter = prefs.getKeyValue(Preferences.allListingCityFilter, 0);
    return filter;
  }

  Future<List<ProductModel>> searchListing(content, int pageNo) async {
    int currentCityFilter = await getCurrentCityFilter();
    List<ProductModel>? listDataList = [];
    ///currentListingStatus: 1 only for recent Listings
    MultiFilter multiFilter = MultiFilter(
        hasLocationFilter: true,
      hasCategoryFilter:true,
      hasListingStatusFilter:true,
      currentLocation: currentCityFilter,
      currentListingStatus: 1,
      currentCategory: 1,);

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
}
