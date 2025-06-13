import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_citizen_service.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

import 'discovery_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState.loading());

  List<CitizenServiceModel> list = [];
  List<CitizenServiceModel> listLoaded = [];
  List<CitizenServiceModel> filteredList = [];
  List<CategoryModel> location = [];
  final List<CitizenServiceModel> hiddenServices = [];
  late List<CitizenServiceModel> services;
  late List<CitizenServiceModel> explore;
  bool doesScroll = false;
  int? currentCity;

  Future<void> onLoad() async {
    emit(const DiscoveryState.loading());
    final cityRequestResponse = await Api.requestCities();
    location = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    services = initializeServices()[0];
    explore = initializeServices()[1];

    List<CitizenServiceModel> servicesCopy = List.from(services);

    /*for (var element in servicesCopy) {
      if (element.categoryId != null || element.type == "subCategoryService") {
        // bool hasContent = await element.hasContent();
        // if (!hasContent) {
        //   hiddenServices.add(element);
        // }
      }
    }*/

    services.removeWhere((element) => hiddenServices.contains(element));

    await getCitySelected();

    emit(DiscoveryStateLoaded(services, explore));
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
    saveToMatomo(cityId);
  }

  Future<void> saveToMatomo(int cityId) async {
    String? cityName;
    if (cityId != 0) {
      cityName =
          location.firstWhereOrNull((element) => element.id == cityId)?.title;
      if (cityName == null) {
        logError('[MATOMO] Could not find name for cityId: $cityId');
        return;
      }
    } else {
      cityName = 'Alle-Orte';
    }
    ListRepository.saveEventToMatomo(type: MatomoType.city, name: cityName);
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
    emit(DiscoveryStateLoaded(services, explore));
  }

  List<List<CitizenServiceModel>> initializeServices() {
    List<CitizenServiceModel> services = [
      CitizenServiceModel(
        imageUrl: Images.service23,
        imageLink: "23",
        arguments: 23,
      ),
      CitizenServiceModel(
        imageUrl: Images.service24,
        imageLink: "24",
        arguments: 24,
      ),
      CitizenServiceModel(
        imageUrl: Images.service25,
        imageLink: "25",
        arguments: 25,
      ),
    ];
    List<CitizenServiceModel> explore = [
      CitizenServiceModel(
        imageUrl: Images.service17,
        imageLink: "17",
        arguments: 17,
      ),
      CitizenServiceModel(
        imageUrl: Images.service18,
        imageLink: "18",
        arguments: 18,
      ),
      CitizenServiceModel(
        imageUrl: Images.service19,
        imageLink: "19",
        arguments: 19,
      ),
      CitizenServiceModel(
        imageUrl: Images.service20,
        imageLink: "20",
        arguments: 20,
      ),
      CitizenServiceModel(
        imageUrl: Images.service21,
        imageLink: "21",
        arguments: 21,
      ),
      CitizenServiceModel(
        imageUrl: Images.service22,
        imageLink: "22",
        arguments: 22,
      ),
    ];

    return [services, explore];
  }

  Future<int?> getCitySelected() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, 0);
    currentCity = cityId;
    return cityId;
  }
}
