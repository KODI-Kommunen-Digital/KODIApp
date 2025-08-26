import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/cubit.dart';

import '../../presentation/main/home/forum/list_groups/cubit/list_groups_cubit.dart';

class MultiFilter {
  final ProductFilter? currentProductEventFilter; //ListProduct filter
  final GroupFilter? currentForumGroupFilter; //Forum group filter
  final DayTimeFilter? currentDayTimeFilter;
  final int? currentListingStatus; //Listing status in All Listings
  final int? currentCategory; //Listing category in ListProduct city
  final int? currentSubCategory; //Listing sub category in ListProduct city

  final List<CategoryModel>? cities; //All cities
  final List<CategoryModel>? categories;
  final dynamic currentLocation; //Location IDs
  final Map<int,String>? subCategoriesMap;
  final Map<DayTimeFilter,String>? dayTimeMap;
  final bool hasListingStatusFilter;
  final bool hasForumGroupFilter;
  final bool hasProductEventFilter;
  final bool hasLocationFilter;
  final bool hasCategoryFilter;
  final bool hasSubCategoryFilter;
  final bool hasDateRangeFilter;
  final bool hasDayTimeFilter;
  final DateTime? startAfterDate;
  final DateTime? endAfterDate;
  final bool hasMultipleCityFilter;
  final List<int>? selectedCities;

  MultiFilter(
      {this.currentLocation,
        this.cities,
        this.categories,
        this.subCategoriesMap,
        this.dayTimeMap,
        this.currentDayTimeFilter,
        this.currentForumGroupFilter,
        this.currentListingStatus,
        this.currentProductEventFilter,
        this.currentCategory,
        this.currentSubCategory,
        this.hasDayTimeFilter = false,
        this.hasDateRangeFilter = false,
        this.hasListingStatusFilter = false,
        this.hasForumGroupFilter = false,
        this.hasProductEventFilter = false,
        this.hasLocationFilter = false,
        this.hasCategoryFilter = false,
        this.hasMultipleCityFilter = false,
        this.hasSubCategoryFilter = false,
        this.startAfterDate,
        this.endAfterDate,
        this.selectedCities
      });
}