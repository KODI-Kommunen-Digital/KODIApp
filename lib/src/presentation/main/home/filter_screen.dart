import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/presentation/main/home/forum/list_groups/cubit/cubit.dart';
import 'package:heidi/src/presentation/main/home/list_product/cubit/list_cubit.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:intl/intl.dart';

class FilterScreen extends StatefulWidget {
  final MultiFilter multiFilter;

  const FilterScreen({super.key, required this.multiFilter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int? currentCity;
  List<int> currentCities = [];
  int? currentCategory;
  int? currentSubCategory;
  int? currentListingStatus;
  ProductFilter? currentProductEventFilter;
  GroupFilter? currentForumGroupFilter;
  Map<int,String>? subCategoriesMap;
   Map<DayTimeFilter,String>? dayTimeMap;
  DateTime? startAfterDate;
  DateTime? endAfterDate;
  DayTimeFilter? currentDayTimeFilter;

  @override
  void initState() {
    super.initState();
    if (widget.multiFilter.hasMultipleCityFilter|| widget.multiFilter.hasLocationFilter) {
      currentCities = widget.multiFilter.selectedCities??[0];
    }
    if(widget.multiFilter.hasSubCategoryFilter){
      subCategoriesMap = widget.multiFilter.subCategoriesMap;
    }
    if(widget.multiFilter.hasDateRangeFilter) {
      dayTimeMap = widget.multiFilter.dayTimeMap;
    }
    if(widget.multiFilter.hasDayTimeFilter) {
      currentDayTimeFilter = widget.multiFilter.currentDayTimeFilter;
    }
    currentCategory = widget.multiFilter.currentCategory;
    currentProductEventFilter = widget.multiFilter.currentProductEventFilter;
    currentListingStatus = widget.multiFilter.currentListingStatus;
    currentForumGroupFilter = widget.multiFilter.currentForumGroupFilter;
    startAfterDate = widget.multiFilter.startAfterDate;
    endAfterDate = widget.multiFilter.endAfterDate;
    currentSubCategory = widget.multiFilter.currentSubCategory;
    currentCities = widget.multiFilter.selectedCities ?? [0];
  }

  bool _isFilterApplied() {
    if (widget.multiFilter.hasMultipleCityFilter) {
      if (currentCities.length != 1 || currentCities.first != 0) return true;
    } else if (widget.multiFilter.hasLocationFilter) {
      if (currentCity != null && currentCity != 0) return true;
    }

    if (widget.multiFilter.hasCategoryFilter &&
        currentCategory != null &&
        currentCategory != 0) {
      return true;
    }

    if (widget.multiFilter.hasSubCategoryFilter &&
        currentSubCategory != null &&
        currentSubCategory != 0) {
      return true;
    }

    if (widget.multiFilter.hasListingStatusFilter &&
        currentListingStatus != null &&
        currentListingStatus != 0) {
      return true;
    }

    if (widget.multiFilter.hasProductEventFilter &&
        currentProductEventFilter != null) {
      return true;
    }

    if (widget.multiFilter.hasForumGroupFilter &&
        currentForumGroupFilter != null &&
        currentForumGroupFilter != GroupFilter.allGroups) {
      return true;
    }

    if (widget.multiFilter.hasDateRangeFilter &&
        (startAfterDate != null || endAfterDate != null)) {
      return true;
    }

    if (widget.multiFilter.hasDayTimeFilter &&
        currentDayTimeFilter != null &&
        currentDayTimeFilter != DayTimeFilter.all) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  currentCity = 0;
                  currentCities = [0];
                  startAfterDate = null;
                  endAfterDate = null;
                  currentSubCategory = null;
                  currentDayTimeFilter = null;
                  currentCategory = 0;
                  currentProductEventFilter = null;
                  currentListingStatus = 0;
                  currentForumGroupFilter = GroupFilter.allGroups;
                });
              },
              icon: Icon(Icons.refresh,
                  color: _isFilterApplied()
                      ? Theme.of(context).primaryColor
                      : null))
        ],
      ),
      body: SingleChildScrollView(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop) return;
            if(startAfterDate!=null && endAfterDate ==null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Translate.of(context).translate(
                        'please_select_end_date_to_apply_filter'),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            } else {
              Navigator.pop(
                  context,
                  MultiFilter(
                      currentLocation: (widget.multiFilter.hasMultipleCityFilter)
                          ? currentCities
                          : currentCity,
                      currentProductEventFilter: currentProductEventFilter,
                      cities: widget.multiFilter.cities,
                      currentListingStatus: currentListingStatus,
                      currentForumGroupFilter: currentForumGroupFilter,
                      currentCategory: currentCategory,
                      hasForumGroupFilter: widget.multiFilter.hasForumGroupFilter,
                      hasProductEventFilter:
                      widget.multiFilter.hasProductEventFilter,
                      hasLocationFilter: widget.multiFilter.hasLocationFilter,
                      hasListingStatusFilter:
                      widget.multiFilter.hasListingStatusFilter,
                      hasCategoryFilter: widget.multiFilter.hasCategoryFilter,
                      startAfterDate: startAfterDate,
                      endAfterDate: endAfterDate,
                      currentSubCategory: currentSubCategory,
                      currentDayTimeFilter: currentDayTimeFilter,
                      subCategoriesMap: subCategoriesMap,
                      dayTimeMap: dayTimeMap,
                      hasSubCategoryFilter:
                      widget.multiFilter.hasSubCategoryFilter,
                      hasDayTimeFilter: widget.multiFilter.hasDayTimeFilter,
                      hasDateRangeFilter: widget.multiFilter.hasDateRangeFilter,
                      hasMultipleCityFilter: widget.multiFilter.hasMultipleCityFilter,
                      selectedCities: currentCities
                  ));
            }
          },
          child: Column(
            children: [
              if (widget.multiFilter.hasLocationFilter == true)
                ..._buildLocationFilter(),
              if (widget.multiFilter.hasProductEventFilter == true)
                ..._buildProductEventFilter(),
              if (widget.multiFilter.hasDateRangeFilter == true)
                ..._buildDateRangeFilter(),
              if (widget.multiFilter.hasListingStatusFilter == true)
                ..._buildListingStatusFilter(),
              if (widget.multiFilter.hasForumGroupFilter == true)
                ..._buildForumGroupFilter(),
              if (widget.multiFilter.hasCategoryFilter == true)
                ..._buildCategoryFilter(),
              if (widget.multiFilter.hasSubCategoryFilter == true)
                ..._buildSubCategoryFilter(),
              if (widget.multiFilter.hasSubCategoryFilter == true)
                ..._buildDayTimeFilter(),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List<Widget> _buildLocationFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('choose_city'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          (widget.multiFilter.hasMultipleCityFilter)
              ? ChoiceChip(
                  label:
                      Text(Translate.of(context).translate('select_location')),
                  selected: currentCities.contains(0),
                  onSelected: (selected) {
                    setState(() {
                      currentCities = [];
                      currentCities.add(0);
                    });
                  },
                )
              : ChoiceChip(
                  label:
                      Text(Translate.of(context).translate('select_location')),
                  selected: 0 == currentCity,
                  onSelected: (selected) {
                    setState(() {
                      currentCity = 0;
                    });
                  },
                ),
                ...widget.multiFilter.cities!.map((city) {
                  return (widget.multiFilter.hasMultipleCityFilter)
                      ? ChoiceChip(
                          label: Text(city.title),
                          selected: currentCities.contains(city.id),
                          onSelected: (selected) {
                            setState(() {

                              if (currentCities.contains(city.id)) {
                                currentCities.remove(city.id);
                              } else {
                                currentCities.add(city.id);
                                currentCities.remove(0);
                              }
                            });
                          },
                        )
                      : ChoiceChip(
                          label: Text(city.title),
                          selected: city.id == currentCity,
                          onSelected: (selected) {
                            setState(() {
                              currentCity = city.id;
                            });
                          },
                        );
                }),
        ]),
      )
    ];
  }

  List<Widget> _buildListingStatusFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('choose_listing_status'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all')),
            selected: currentListingStatus == 0,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 0;
                startAfterDate = null;
              });
            },
          ),
          ChoiceChip(
            label: Text(Translate.of(context).translate('active')),
            selected: currentListingStatus == 1,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 1;
              });
            },
          ),
          ChoiceChip(
            label: Text(Translate.of(context).translate('inactive')),
            selected: currentListingStatus == 2,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 2;
              });
            },
          ),
          ChoiceChip(
            label: Text(Translate.of(context).translate('under_review')),
            selected: currentListingStatus == 3,
            onSelected: (selected) {
              setState(() {
                currentListingStatus = 3;
              });
            },
          ),
        ]),
      )
    ];
  }

  List<Widget> _buildForumGroupFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('choose_forum'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('all_groups')),
                Icon(
                  Icons.groups,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentForumGroupFilter == GroupFilter.allGroups,
            onSelected: (selected) {
              setState(() {
                currentForumGroupFilter = GroupFilter.allGroups;
              });
            },
          ),
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('my_groups')),
                Icon(
                  Icons.person,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentForumGroupFilter == GroupFilter.myGroups,
            onSelected: (selected) {
              setState(() {
                currentForumGroupFilter = GroupFilter.myGroups;
              });
            },
          ),
        ]),
      )
    ];
  }

  List<Widget> _buildProductEventFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('time_period'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all')),
            selected: currentProductEventFilter == null,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = null;
                startAfterDate = null;
              });
            },
          ),
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('this_month')),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentProductEventFilter == ProductFilter.month,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = ProductFilter.month;
                startAfterDate = null;
              });
            },
          ),
          ChoiceChip(
            label: Wrap(
              spacing: 4.0,
              children: [
                Text(Translate.of(context).translate('this_week')),
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  size: 18,
                )
              ],
            ),
            selected: currentProductEventFilter == ProductFilter.week,
            onSelected: (selected) {
              setState(() {
                currentProductEventFilter = ProductFilter.week;
                startAfterDate = null;
              });
            },
          ),
          // Custom date filter
          ChoiceChip(
            label: Text(
              startAfterDate == null
                  ? Translate.of(context).translate('custom_date')
                  : DateFormat('yyyy-MM-dd').format(startAfterDate!),
            ),
            selected: currentProductEventFilter == ProductFilter.custom,
            onSelected: (selected) async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: startAfterDate ??
                    DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  startAfterDate = pickedDate;
                  currentProductEventFilter = ProductFilter.custom;
                });
              }
            },
          ),
          // Clear custom date filter
          if (startAfterDate != null)
            ChoiceChip(
              label: Text(Translate.of(context).translate('clear_date')),
              selected: false,
              onSelected: (selected) {
                setState(() {
                  startAfterDate = null;
                });
              },
            ),
        ]),
      )
    ];
  }

  List<Widget> _buildCategoryFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
        Translate.of(context).translate('input_category'),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all_Categories')),
            selected: 0 == currentCategory,
            onSelected: (selected) {
              setState(() {
                currentCategory = 0;
              });
            },
          ),
          if(widget.multiFilter.categories!=null)
            ...widget.multiFilter.categories!.map((category) {
              return ChoiceChip(
                label: Text(category.title),
                selected: category.id == currentCategory,
                onSelected: (selected) {
                  setState(() {
                    currentCategory = category.id;
                  });
                },
              );
            }),
        ]),
      )
    ];
  }

  List<Widget> _buildDateRangeFilter() {
    return [
      const SizedBox(height: 8),
      Center(
        child: Text(
          Translate.of(context).translate('time_period'),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          /// Start date chip
          ChoiceChip(
            label: Text(
              startAfterDate == null
                  ? Translate.of(context).translate('from_date')
                  : DateFormat('yyyy-MM-dd').format(startAfterDate!),
            ),
            selected: startAfterDate != null,
            onSelected: (selected) async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: startAfterDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  startAfterDate = pickedDate;
                  currentProductEventFilter = ProductFilter.custom;

                  if (endAfterDate != null &&
                      endAfterDate!.isBefore(pickedDate)) {
                    endAfterDate = null;
                  }
                });
              }
            },
          ),

          /// Clear start date
          if (startAfterDate != null)

            ChoiceChip(
              label: Text(Translate.of(context).translate('clear_date')),
              selected: false,
              onSelected: (_) {
                setState(() {
                  startAfterDate = null;
                  endAfterDate = null;
                });
              },
            ),

          /// End date chip
          ChoiceChip(
            label: Text(
              endAfterDate == null
                  ? Translate.of(context).translate('to_date')
                  : DateFormat('yyyy-MM-dd').format(endAfterDate!),
            ),
            selected: endAfterDate != null,
            onSelected: (selected) async {
              if (startAfterDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      Translate.of(context).translate(
                          'please_select_start_date_first'),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: endAfterDate ?? startAfterDate!,
                firstDate: startAfterDate!,
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  endAfterDate = pickedDate;
                });
              }
            },
          ),

          /// Clear end date
          if (endAfterDate != null)
            ChoiceChip(
              label: Text(Translate.of(context).translate('clear_date')),
              selected: false,
              onSelected: (_) {
                setState(() {
                  endAfterDate = null;
                });
              },
            ),
        ]),
      ),
    ];
  }

  List<Widget> _buildSubCategoryFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
            Translate.of(context).translate('input_category'),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all_sub_Categories')),
            selected: 0 == currentSubCategory,
            onSelected: (selected) {
              setState(() {
                if (currentSubCategory == 0) {
                  currentSubCategory = null;
                } else {
                  currentSubCategory = 0;
                }
              });
            },
          ),
          if (widget.multiFilter.subCategoriesMap != null)
            ...widget.multiFilter.subCategoriesMap!.entries.map((entry) {
              final subCategoryId = entry.key;    // int
              final subCategoryName = entry.value; // String
              return ChoiceChip(
                label: Text(Translate.of(context).translate(subCategoryName)),
                selected: subCategoryId == currentSubCategory,
                onSelected: (selected) {
                  setState(() {
                    if (currentSubCategory == subCategoryId) {
                      currentSubCategory = null;
                    } else {
                      currentSubCategory = subCategoryId;
                    }
                  });
                },
              );
            }).toList(),
        ]),
      )
    ];
  }

  List<Widget> _buildDayTimeFilter() {
    return [
      const SizedBox(
        height: 8,
      ),
      Center(
          child: Text(
            Translate.of(context).translate('time_of_day'),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          )),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(spacing: 8.0, children: [
          ChoiceChip(
            label: Text(Translate.of(context).translate('all_times_of_the_day')),
            selected: DayTimeFilter.all == currentDayTimeFilter,
            onSelected: (selected) {
              setState(() {
                if(currentDayTimeFilter == DayTimeFilter.all) {
                  currentDayTimeFilter = null;
                } else {
                  currentDayTimeFilter = DayTimeFilter.all;
                }
              });
            },
          ),
          if (widget.multiFilter.dayTimeMap != null)
            ...widget.multiFilter.dayTimeMap!.entries.map((entry) {
              DayTimeFilter filterType = entry.key;
              String filterName = entry.value;
              return ChoiceChip(
                label: Text(Translate.of(context).translate(filterName)),
                selected: filterType == currentDayTimeFilter,
                onSelected: (selected) {
                  setState(() {
                    if(currentDayTimeFilter == filterType) {
                      currentDayTimeFilter = null;
                    } else {
                      currentDayTimeFilter = filterType;
                    }
                  });
                },
              );
            }).toList(),
        ]),
      )
    ];
  }


}
