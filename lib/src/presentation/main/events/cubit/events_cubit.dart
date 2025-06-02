import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

// ignore: depend_on_referenced_packages
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(const EventsState.loading());

  Map<int, String> locations = {};
  int cityId = 0;
  MultiFilter? filter;
  List<ProductModel> loadedEvents = [];

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) emit(const EventsState.loading());
    final prefs = await Preferences.openBox();
    if (filter?.currentLocation != null) {
      cityId = filter!.currentLocation;
    } else {
      final List<CategoryModel>? cities = await getCityList();
      if (cities == null) {
        emit(const EventsState.error("no_valid_data"));
        return;
      }
      for(var city in cities) {
        locations[city.id] = city.title;
      }
      final int savedCityId = prefs.getKeyValue(Preferences.cityId, 0);
      cityId = matchCityId(cities, savedCityId);
    }

    final eventsResponse = await ListRepository.loadList(
        categoryId: 3, type: "category", pageNo: 1, cityId: cityId);

    List<ProductModel> eventsList = [];

    if(eventsResponse != null) {
      eventsList = eventsResponse[0];
    }
    if(filter != null && filter!.currentProductEventFilter != null) {
      final List<ProductModel>? formattedList = formatListDateFilter(filter!.currentProductEventFilter, eventsList, false, null);
      if(formattedList != null) {
        eventsList = formattedList;
      }
    }
    filter ??= MultiFilter(hasLocationFilter: true, hasProductEventFilter: true, currentLocation: cityId);

    loadedEvents.addAll(eventsList);
    emit(EventsState.loaded(eventsList));
  }

  Future<void> newEvents(int pageNo) async {
    final eventsResponse = await ListRepository.loadList(
        categoryId: 3, type: "category", pageNo: pageNo, cityId: cityId);
    List<ProductModel> eventsList = [];

    if(eventsResponse != null) {
      eventsList = eventsResponse[0];
      loadedEvents.addAll(eventsList);
    }
    emit(EventsState.updated(loadedEvents));
  }

  //This is not a good solution, filter from the backend!
  List<ProductModel>? formatListDateFilter(ProductFilter? type, List<ProductModel> loadedList,
      bool filterLocation, List<int>? currentCity) {
    List<ProductModel>? filteredList;
    final currentDate = DateTime.now();
    if (type == ProductFilter.month) {
      filteredList = loadedList.where((product) {
        final startDate = ListCubit.parseDate(product.startDate);
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
    } else if (type == ProductFilter.week) {
      filteredList = loadedList.where((product) {
        final startDate = ListCubit.parseDate(product.startDate);
        if (startDate != null) {
          final startWeek = ListCubit.getWeekNumber(startDate);
          final currentWeek = ListCubit.getWeekNumber(currentDate);
          if (filterLocation && (currentCity ?? []).isNotEmpty) {
            return (startWeek == currentWeek) &&
                (currentCity!.contains(product.cityId));
          } else {
            return startWeek == currentWeek;
          }
        }
        return false;
      }).toList();
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
    }
    return filteredList;
  }

  int matchCityId(List<CategoryModel> cities, int cityId) {
    return cities.firstWhereOrNull((element) => element.id == cityId)?.id ?? 0;
  }

  Future<List<CategoryModel>?> getCityList() async {
    final cityRequestResponse = await Api.requestCities();

    if (cityRequestResponse.data != null && cityRequestResponse.data is List) {
      List<dynamic> cities = List.from(cityRequestResponse.data);

      cities.sort((a, b) {
        String nameA = (a['name'] ?? '').toString().toLowerCase();
        String nameB = (b['name'] ?? '').toString().toLowerCase();
        return nameA.compareTo(nameB);
      });

      dynamic location = cities.map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      return location;
    } else {
      return null;
    }
  }

  Future<List<ProductModel>?> searchListing(content, int pageNo) async {
    /*
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

    return listDataList;*/
  }

  Future<dynamic> newListings(int pageNo) async {}
}
