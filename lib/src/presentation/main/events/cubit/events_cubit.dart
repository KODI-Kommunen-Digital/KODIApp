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
import 'package:intl/intl.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(const EventsState.loading());

  Map<int, String> locations = {};
  int cityId = 0;
  MultiFilter? filter;
  List<ProductModel> loadedEvents = [];
  String? searchTerm;

  Future<void> onLoad(bool isRefreshLoader, int pageNo) async {
    if (!isRefreshLoader) {
      emit(const EventsState.loading());
      searchTerm = null;
    }
    final prefs = await Preferences.openBox();
    List<CategoryModel>? filterCities;
    if (filter?.currentLocation != null) {
      cityId = filter!.currentLocation;
    } else {
      final List<CategoryModel>? cities = await getCityList();
      if (cities == null) {
        emit(const EventsState.error("no_valid_data"));
        return;
      }
      for (var city in cities) {
        locations[city.id] = city.title;
      }
      final int savedCityId = prefs.getKeyValue(Preferences.cityId, 0);
      cityId = matchCityId(cities, savedCityId);
      filterCities = cities;
    }

    final eventsResponse = await ListRepository.loadList(
        categoryId: 3, type: "category", pageNo: 1, cityId: cityId);

    List<ProductModel> eventsList = [];

    if (eventsResponse != null) {
      eventsList = eventsResponse[0];
    }

    // if (filter != null && filter!.currentProductEventFilter != null) {
    //   final List<ProductModel>? formattedList = formatListDateFilter(
    //       filter!.currentProductEventFilter, eventsList, false, null);
    //   if (formattedList != null) {
    //     eventsList = formattedList;
    //   }
    // }

    if (filter != null && filter!.startAfterDate != null && filter!.endAfterDate != null) {
      int cityId = filter!.currentLocation;
      int? subCategoryId = filter!.currentSubCategory;
      String? startDate = filter!.startAfterDate != null ? formatDate(
          filter!.startAfterDate!) : null;
      String? endDate = filter!.endAfterDate != null ? formatDate(
          filter!.endAfterDate!) : null;
      String? timeFilter = filter!.currentDayTimeFilter != null
          ? getDayTimeType(filter!.currentDayTimeFilter!)
          : null;
      final eventsResponse = await ListRepository.loadFilteredList(
        categoryId: 3,
        type: "filterType",
        pageNo: pageNo,
        cityId: cityId,
        subCategoryId: subCategoryId,
        startDate: startDate,
        endDate: endDate,
        timeFilter: timeFilter,
      );
      List<ProductModel> eventsList = [];
      if (eventsResponse != null) {
        eventsList = eventsResponse[0];
        loadedEvents = eventsList;
      }
    }

    Map<int, String> subcategories = ListCubit.getSubCategoriesEvents();
    Map<DayTimeFilter, String> dayTimeMap = ListCubit.getDayTimeFilters();




    filter ??= MultiFilter(
        hasLocationFilter: true,
        hasDateRangeFilter: true,
        hasDayTimeFilter: true,
        hasSubCategoryFilter: true,
        subCategoriesMap: subcategories,
        dayTimeMap: dayTimeMap,
        currentLocation: cityId,
        cities: filterCities);

    loadedEvents.addAll(eventsList);
    emit(EventsState.loaded(eventsList));
  }

  Future<void> newEvents(int pageNo) async {
    final eventsResponse = await ListRepository.loadList(
        categoryId: 3, type: "category", pageNo: pageNo, cityId: cityId);
    List<ProductModel> eventsList = [];

    if (eventsResponse != null) {
      eventsList = eventsResponse[0];
      loadedEvents.addAll(eventsList);
    }
    emit(EventsState.updated(loadedEvents));
  }

  //This is not a good solution, filter from the backend!
  List<ProductModel>? formatListDateFilter(
      ProductFilter? type,
      List<ProductModel> loadedList,
      bool filterLocation,
      List<int>? currentCity) {
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

  Future<void> searchListing(String content, int pageNo) async {
    emit(const EventsState.loading());
    searchTerm = content;

    final eventsResponse = await ListRepository.loadFilteredList(
        categoryId: 3,
        type: "searchListings",
        pageNo: pageNo,
        searchTerm: searchTerm);
    List<ProductModel> eventsList = [];

    if (eventsResponse != null) {
      eventsList = eventsResponse[0];
      loadedEvents = eventsList;
    }
    emit(EventsState.loaded(loadedEvents));
  }

  Future<void> onFilter(MultiFilter selectedFilter, int pageNo) async {
    emit(const EventsState.loading());
    filter = selectedFilter;
    int cityId = selectedFilter.currentLocation;
    int? subCategoryId = selectedFilter.currentSubCategory;
    String? startDate = selectedFilter.startAfterDate != null ? formatDate(
        selectedFilter.startAfterDate!) : null;
    String? endDate = selectedFilter.endAfterDate != null ? formatDate(
        selectedFilter.endAfterDate!) : null;
    String? timeFilter = selectedFilter.currentDayTimeFilter != null
        ? getDayTimeType(selectedFilter.currentDayTimeFilter!)
        : null;

    final eventsResponse = await ListRepository.loadFilteredList(
      categoryId: 3,
      type: "filterType",
      pageNo: pageNo,
      cityId: cityId,
      subCategoryId: subCategoryId,
      startDate: startDate,
      endDate: endDate,
      timeFilter: timeFilter,
    );
    List<ProductModel> eventsList = [];

    if (eventsResponse != null) {
      eventsList = eventsResponse[0];
      loadedEvents = eventsList;
    }
    emit(EventsState.loaded(loadedEvents));
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String? getDayTimeType(DayTimeFilter dayTimeFilter) {
    switch (dayTimeFilter) {
      case DayTimeFilter.morning:
        return "morning";
      case DayTimeFilter.daytime:
        return "daytime";
      case DayTimeFilter.afternoon:
        return "afternoon";
      case DayTimeFilter.evening:
        return "evening";
      case DayTimeFilter.night:
        return "night";
      default:
        return null;
    }
  }
}
