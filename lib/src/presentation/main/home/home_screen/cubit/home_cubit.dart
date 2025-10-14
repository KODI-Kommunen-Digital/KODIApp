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
  // Flag to avoid reloading discovery cubit on hot reload
  bool calledExternally = false;
  List<CategoryModel> location=[];

  HomeCubit() : super(const HomeState.initial());


  Future<void> onLoad(bool isRefreshLoader) async {
    // For pull-to-refresh, we don't show a full-screen loader
    if (!isRefreshLoader) {
      emit(const HomeState.loading());
    }

    try {
      if (!await hasInternet()) {
        emit(const HomeState.error("no_internet"));
        return;
      }

      // Parallelize independent API calls
      final [
        cityRequestResponse,
        categoryRequestResponse,
      ] = await Future.wait([
        Api.requestCities(),
        Api.requestHomeCategory(),
      ]);

       final locations = List.from(cityRequestResponse.data ?? [])
          .map((item) => CategoryModel.fromJson(item))
          .toList();
       location=locations;

      final categories = List.from(categoryRequestResponse.data ?? [])
          .map((item) => CategoryModel.fromJson(item))
          .toList();

      if (!calledExternally && !isRefreshLoader) {
        await AppBloc.discoveryCubit.onLoad();
      }

      final savedCity = await checkSavedCity(locations);

      // Fetch data that depends on the saved city
      final [
        listingsResponse,
        companyResponse,
        categoryCountResponse,
      ] = await Future.wait([
        savedCity != null
            ? Api.requestLocList(savedCity.id, 1)
            : Api.requestRecentListings(1),
        Api.requestCatList(10, savedCity, 1, true),
        Api.requestCategoryCount(savedCity?.id),
      ]);

      final recent = List.from(listingsResponse.data ?? [])
          .map((item) => ProductModel.fromJson(item))
          .toList();

      final company = List.from(companyResponse.data ?? [])
          .map((item) => ProductModel.fromJson(item))
          .toList();

      final categoryCount = List.from(categoryCountResponse.data ?? [])
          .map((item) => CategoryModel.fromJson(item))
          .toList();

      final formattedCategories =
          getCategoriesWithoutHidden(await formatCategoriesList(categories, categoryCount));

      emit(HomeStateLoaded(
        Images.slider,
        formattedCategories,
        locations,
        recent,
        company,
        isRefreshLoader,
        false
      ));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  Future<void> newCompanies(int pageNo) async {
    final currentState = state;
    if (currentState is! HomeStateLoaded || currentState.isPaginating) {
      return;
    }

    emit(currentState.copyWith(isPaginating: true));

    try {
      if (!await hasInternet()) {
        emit(const HomeState.error("no_internet"));
        emit(currentState.copyWith(isPaginating: false));
        return;
      }

      final listingsRequestResponse =
          await Api.requestCatList(10, null, pageNo, false);
      final newCompanies = List.from(listingsRequestResponse.data ?? [])
          .map((item) => ProductModel.fromJson(item))
          .toList();

      final updatedCompanies = List<ProductModel>.from(currentState.company)
        ..addAll(newCompanies);

      emit(currentState.copyWith(
        company: updatedCompanies,
        isPaginating: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isPaginating: false));
    }
  }

  Future<void> saveIgnoreAppVersion(String version) async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(Preferences.ignoredAppVersion, version);
  }

  Future<String> getIgnoreAppVersion() async {
    final prefs = await Preferences.openBox();
    return prefs.getKeyValue(Preferences.ignoredAppVersion, '');
  }

  Future<bool> doesUserExist() async {
    final userId = await UserRepository.getLoggedUserId();
    if (userId == 0) return true; // Assuming 0 means not logged in
    return await UserRepository.doesUserExist(userId);
  }

  bool getCalledExternally() {
    return calledExternally;
  }

  void setCalledExternally(bool called) {
    calledExternally = called;
  }

  Future<List<CategoryModel>> formatCategoriesList(
    List<CategoryModel> categories,
    List<CategoryModel> categoryCount,
  ) async {
    // Pure function: create a new list
    final formattedList = List<CategoryModel>.from(categories);

    // Forum always at index 6, before the more button
    final forumIndex = formattedList.indexWhere((element) => element.id == 17);
    if (forumIndex != -1) {
      final forum = formattedList.removeAt(forumIndex);
      if (formattedList.length >= 6) {
        formattedList.insert(6, forum);
      } else {
        formattedList.add(forum);
      }
    }

    // Hide specific categories
    for (var element in formattedList) {
      if (element.id == 4 || element.id == 20) {
        element.hide = true;
      }
    }

    return formattedList;
  }

  Future<void> saveCityId(int cityId) async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(Preferences.cityId, cityId);
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('dns.google');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  List<CategoryModel> getCategoriesWithoutHidden(
      List<CategoryModel> categoryList) {
    return categoryList.where((element) => !element.hide).toList();
  }

  Future<CategoryModel?> checkSavedCity(List<CategoryModel> cities) async {
    final prefs = await Preferences.openBox();
    final cityId = prefs.getKeyValue(Preferences.cityId, 0);
    if (cityId != 0) {
      try {
        final city = cities.firstWhere((category) => category.id == cityId);
        return CategoryModel(id: cityId, title: city.title, image: "");
      } catch (e) {
        // Saved city not found in the list from API
        return null;
      }
    }
    return null;
  }
}