import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import 'discovery_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState.loading());

  List<CitizenServiceModel> list = [];
  List<CitizenServiceModel> listLoaded = [];
  List<CitizenServiceModel> filteredList = [];
  List<CategoryModel> location = [];
  final List<CitizenServiceModel> hiddenServices = [];
  late List<CitizenServiceModel> services;
  bool doesScroll = false;
  int? currentCity;

  Future<void> onLoad() async {
    emit(const DiscoveryState.loading());
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    services = initializeServices();

    List<CitizenServiceModel> servicesCopy = List.from(services);

    for (var element in servicesCopy) {
      if (element.categoryId != null || element.type == "subCategoryService") {
        // bool hasContent = await element.hasContent();
        // if (!hasContent) {
        //   hiddenServices.add(element);
        // }
      }
    }

    services.removeWhere((element) => hiddenServices.contains(element));

    await getCitySelected();

    emit(DiscoveryStateLoaded(
      services,
    ));
  }

  Future<void> onLocationFilter(int locationId, bool calledExternal) async {
    await saveCityId(locationId);
    emit(const DiscoveryState.loading());
    await onLoad();
    if (calledExternal) {
      await AppBloc.homeCubit.onLoad(false);
    }
  }

  Future<void> updateLocationFilter(int locationId) async {
    emit(const DiscoveryState.loading());
    await onLocationFilter(locationId, true);
  }

  Future<void> saveCityId(int cityId) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.cityId, cityId);
  }

  Future<String?> getCityLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    Map<int, String> cityWebsites = {
      0: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger",
      1: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86974&behoerde=29997690498&gemeinde=325524110678",
      2: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86925&behoerde=70664072559&gemeinde=006746347678",
      3: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=86944&behoerde=93996542745&gemeinde=208079671678",
    };

    return cityWebsites[cityId];
  }

  Future<void> setServiceValue(String preference, String? type, int? id) async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(preference, type ?? id);
  }

  bool getDoesScroll() {
    return doesScroll;
  }

  void setDoesScroll(bool scroll) {
    doesScroll = scroll;
  }

  void scrollUp() {
    emit(const DiscoveryStateLoading());
    emit(DiscoveryStateLoaded(services));
  }

  List<CitizenServiceModel> initializeServices() {
    List<CitizenServiceModel> services = [
      // CitizenServiceModel(imageUrl: Images.service2, imageLink: "2"),
      // CitizenServiceModel(
      //     imageUrl: Images.service3,
      //     imageLink: "3",
      //     type: "subCategoryService",
      //     arguments: 4),
      CitizenServiceModel(
          imageUrl: Images.service5,
          imageLink: "5",
          arguments: 5,
          categoryId: 3),
      CitizenServiceModel(
          imageUrl: Images.service4,
          imageLink: "4",
          arguments: 4,
          categoryId: 1),
      // CitizenServiceModel(
      //     imageUrl: Images.service8,
      //     imageLink: "8",
      //     arguments: 8,
      //     categoryId: 43),
      // CitizenServiceModel(
      //     imageUrl: Images.service6,
      //     imageLink: "6",
      //     arguments: 6,
      //     categoryId: 4),
      // CitizenServiceModel(
      //     imageUrl: Images.service500,
      //     imageLink: "500",
      //     arguments: 500,
      //     categoryId: 46),
      // CitizenServiceModel(
      //     imageUrl: Images.service31,
      //     imageLink: "31",
      //     arguments: 31,
      //     categoryId: 44),
      // CitizenServiceModel(
      //     imageUrl: Images.service501,
      //     imageLink: "501",
      //     arguments: 501,
      //     categoryId: 45),
      // CitizenServiceModel(
      //     imageUrl: Images.service17,
      //     imageLink: "17",
      //     arguments: 17,
      //     categoryId: 17),
      // CitizenServiceModel(
      //     imageUrl: Images.service11,
      //     imageLink: "11",
      //     arguments: 11,
      //     categoryId: 5),
      // CitizenServiceModel(
      //   imageUrl: Images.service10,
      //   imageLink: "10",
      //   arguments: 10,
      // ),
    ];

    if (currentCity == 2) {
      services.add(
        CitizenServiceModel(imageUrl: Images.service37, imageLink: "37"),
      );
    }
    return services;
  }

  Future<int?> getCitySelected() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    currentCity = cityId;
    return cityId;
  }
}
