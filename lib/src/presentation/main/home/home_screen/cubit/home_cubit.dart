import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  dynamic category;
  dynamic location;
  dynamic recent;
  dynamic sliders;
  dynamic categoryCount;
  bool calledExternally = false;
  bool doesScroll = false;

  HomeCubit() : super(const HomeState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!await hasInternet()) {
      emit(const HomeState.error("no_internet"));
    }
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

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
    /*
    final categoryCountRequestResponse =
        await Api.requestCategoryCount(savedCity?.id);
    categoryCount =
        List.from(categoryCountRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();*/

    const banner = Images.slider;

    /*List<CategoryModel> formattedCategories =
        await formatCategoriesList(category, categoryCount, savedCity?.id);*/

    List<CategoryModel> formattedCategories = await formatCategoriesList(category, savedCity?.id);

    emit(HomeStateLoaded(
      banner,
      formattedCategories,
      location,
      recent,
      isRefreshLoader,
    ));
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
      banner,
      category,
      location,
      recent,
      false,
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
      List<CategoryModel> categories, int? cityId) async {
    // Sort List
    List<int> categoryOrder = [1, 3, 10, 13, 4, 14, 5, 6, 11, 15, 12, 9, 16];

    List<CategoryModel> sortedCategories = [];
    List<CategoryModel> remainingCategories = [];

    for (var categoryId in categoryOrder) {
      var category = categories.firstWhere((cat) => cat.id == categoryId);
      sortedCategories.add(category);
    }

    remainingCategories =
        categories.where((cat) => !categoryOrder.contains(cat.id)).toList();
    sortedCategories.addAll(remainingCategories);

    // Hide tag on empty categories
    for (var element in sortedCategories) {
      bool hasContent = await categoryHasContent(element.id, cityId);
      if (!hasContent) {
        element.hide = true;
      }
      if (element.id == 14) {
        element.hide = false;
      }
    }

    return sortedCategories;
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
}
