import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
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
  int? currentCategory;
  int? currentListingStatus;
  ProductFilter? currentProductEventFilter;
  DateTime? startAfterDate;

  @override
  void initState() {
    super.initState();
    currentCity = 1;
    currentCategory = widget.multiFilter.currentCategory;
    currentProductEventFilter = widget.multiFilter.currentProductEventFilter;
    currentListingStatus = widget.multiFilter.currentListingStatus;
    startAfterDate = widget.multiFilter.startAfterDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
      ),
      body: SingleChildScrollView(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop) return;
            Navigator.pop(
                context,
                MultiFilter(
                    currentProductEventFilter: currentProductEventFilter,
                    currentListingStatus: currentListingStatus,
                    currentCategory: currentCategory,
                    startAfterDate: startAfterDate,
                    hasProductEventFilter:
                        widget.multiFilter.hasProductEventFilter,
                    hasListingStatusFilter:
                        widget.multiFilter.hasListingStatusFilter,
                    hasCategoryFilter: widget.multiFilter.hasCategoryFilter));
          },
          child: Column(
            children: [
              if (widget.multiFilter.hasProductEventFilter == true)
                ..._buildProductEventFilter(),
              if (widget.multiFilter.hasListingStatusFilter == true)
                ..._buildListingStatusFilter(),
              if (widget.multiFilter.hasCategoryFilter == true)
                ..._buildCategoryFilter(),
            ],
          ),
        ),
      ),
    ));
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

  List<Widget> _buildProductEventFilter() {
    return [
      const SizedBox(height: 8),
      Center(
        child: Text(
          Translate.of(context).translate('choose_time_period'),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8.0,
          children: [
            // All events (no filter)
            ChoiceChip(
              label: Text(Translate.of(context).translate('all')),
              selected:
                  currentProductEventFilter == null && startAfterDate == null,
              onSelected: (selected) {
                setState(() {
                  currentProductEventFilter = null;
                  startAfterDate = null; // Clear the date filter
                });
              },
            ),
            // This month
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
                  ),
                ],
              ),
              selected: currentProductEventFilter == ProductFilter.month,
              onSelected: (selected) {
                setState(() {
                  currentProductEventFilter = ProductFilter.month;
                  startAfterDate = null; // Clear the date filter
                });
              },
            ),
            // This week
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
                  ),
                ],
              ),
              selected: currentProductEventFilter == ProductFilter.week,
              onSelected: (selected) {
                setState(() {
                  currentProductEventFilter = ProductFilter.week;
                  startAfterDate = null; // Clear the date filter
                });
              },
            ),
            // Today
            ChoiceChip(
              label: Wrap(
                spacing: 4.0,
                children: [
                  Text(Translate.of(context).translate('today')),
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                    size: 18,
                  ),
                ],
              ),
              selected: currentProductEventFilter == ProductFilter.day,
              onSelected: (selected) {
                setState(() {
                  currentProductEventFilter = ProductFilter.day;
                  startAfterDate = null; // Clear the date filter
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
              selected: startAfterDate != null,
              onSelected: (selected) async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: startAfterDate ??
                      DateTime.now(), // Use the selected date or today's date
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    startAfterDate = pickedDate;
                    currentProductEventFilter =
                        null; // Clear the time period filter
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
          ],
        ),
      ),
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
}
