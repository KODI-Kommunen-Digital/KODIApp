// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:table_calendar/table_calendar.dart';
import 'cubit/waste_calendar_cubit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/widget/app_multi_select_typeahead.dart';

class WasteCalendar extends StatefulWidget {
  const WasteCalendar({super.key});

  @override
  _WasteCalendarState createState() => _WasteCalendarState();
}

class _WasteCalendarState extends State<WasteCalendar> {
  final _wasteCalenderCubit = WasteCalendarCubit();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  String? _selectedLocationId;
  String? _selectedLocationName;
  List<WasteLocation> locations = [];
  List<WasteType> wasteTypes = [];
  List<WasteType> selectedWasteTypes = [];
  late WasteCalendarRepository repository;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    final prefs = await Preferences.openBox();
    repository = WasteCalendarRepository(prefs);
    _loadLocations();
    _loadWasteTypes();
    _loadLocation();
    _loadSelectedWasteTypes();
  }

  Future<void> _loadLocations() async {
    final fetchedLocations = await repository.loadWasteCalendarStreets(1);
    setState(() {
      if (fetchedLocations != null) {
        locations = fetchedLocations;
      }
    });
  }

  Future<void> _loadWasteTypes() async {
    final fetchedWasteTypes = await repository.loadWasteTypes(1);
    setState(() {
      if (fetchedWasteTypes != null) {
        wasteTypes = fetchedWasteTypes;
      }
    });
  }

  Future<void> _loadSelectedWasteTypes() async {
    final prefs = await Preferences.openBox();
    final savedWasteTypeIds = prefs.getSelectedWasteTypes();
    if (savedWasteTypeIds.isNotEmpty) {
      await _loadWasteTypes();
      setState(() {
        selectedWasteTypes = wasteTypes.where((type) => savedWasteTypeIds.contains(type.id)).toList();
      });
    }
  }

  Future<void> _loadLocation() async {
    final prefs = await Preferences.openBox();
    setState(() {
      _selectedLocationId = prefs.getKeyValue(Preferences.selectedLocationId, null);
      _selectedLocationName = prefs.getKeyValue(Preferences.selectedLocationName, null);
      if (_selectedLocationId == null) {
        _showLocationDialog(context);
      } else {
        _wasteCalenderCubit.loadWasteCollections(1, _selectedLocationId, selectedWasteTypeIds: selectedWasteTypes.map((type) => type.id).toList());
      }
    });
  }

  void _selectLocation(String locationId, String locationName, String hashedStreetName) async {
    setState(() {
      _selectedLocationId = locationId;
      _selectedLocationName = locationName;
    });

    await repository.updateSubscription(
      navigatorKey: navigatorKey,
      cityId: 1,
      locationId: locationId,
      locationName: locationName,
      hashedStreetName: hashedStreetName,
    );

    _wasteCalenderCubit.updateStreetId(locationId, selectedWasteTypeIds: selectedWasteTypes.map((type) => type.id).toList());
  }

  void _selectWasteTypes(List<WasteType> wasteTypes) {
    setState(() {
      selectedWasteTypes = wasteTypes;
    });
  }

  Future<void> _updateWasteTypesSubscription() async {
    if (selectedWasteTypes.isNotEmpty) {
      await repository.updateSubscription(
        navigatorKey: navigatorKey,
        cityId: 1,
        wasteTypeIds: selectedWasteTypes.map((type) => type.id).toList(),
      );
    }
  }

  void _showWasteTypeDialog()  {
 
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: 500,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppMultiSelectTypeAhead(
                          items: wasteTypes,
                          selectedItems: selectedWasteTypes,
                          onSelectionChanged: (selectedTypes) {
                            setState(() {
                              _selectWasteTypes(selectedTypes);
                            });
                          },
                          hintText: 'Abfallarten eingeben',
                          sectionTitle: 'Abfallarten auswählen',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Abbrechen'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: selectedWasteTypes.isEmpty
                                  ? null
                                  : () async {
                                     _updateWasteTypesSubscription();
                                      Navigator.pop(context);
                                    },
                              child: const Text('Bestätigen'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      _loadSelectedWasteTypes();
    });
  }

  void _scrollToValues() {
    Future.delayed(const Duration(milliseconds: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _wasteCalenderCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedLocationName ?? 'Straße auswählen',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit,),
              onPressed: () {
                _showLocationDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.recycling),
              onPressed: () {
                _showWasteTypeDialog();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            "assets/images/garbage.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${_selectedDay.day} ${_selectedDay.monthName()}",
                              style: const TextStyle(fontSize: 22, color: Colors.red),
                            ),
                            Text(
                              _selectedDay.weekdayName(),
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Nächste Abholungen", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
                  builder: (context, state) {
                    if (state is WasteCalendarLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WasteCalendarLoaded) {
                      return SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.carouselCollections.length,
                          itemBuilder: (context, index) {
                            return _buildWasteCard(state.carouselCollections[index]);
                          },
                        ),
                      );
                    } else if (state is WasteCalendarError) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                _buildCalendar(),
                const SizedBox(height: 20),
                Text(
                  "Abholungen für ${_selectedDay.day}.${_selectedDay.month}.${_selectedDay.year}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
                  builder: (context, state) {
                    if (state is WasteCalendarLoaded) {
                      final collectionsForSelectedDay = state.collections.where((collection) => isSameDay(collection.date, _selectedDay)).toList();
                      if (collectionsForSelectedDay.isEmpty) {
                        return const Text("Keine Abholungen für den ausgewählten Tag verfügbar");
                      }
                      return Column(
                        children: removeMultiples(collectionsForSelectedDay)
                            .map((collection) => ListTile(
                                  leading: Icon(Icons.delete, color: _wasteCalenderCubit.getColorForType(collection.type)),
                                  title: Text(
                                    (collection.type.toLowerCase().contains('restmüll')) ? 'Restmüll' : collection.type,
                                  ),
                                ))
                            .toList(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 100)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<WasteCollection> removeMultiples(List<WasteCollection> collectionsForSelectedDay) {
    final List<WasteCollection> filteredCollections = [];
    bool restmuellSeen = false;

    for (var collection in collectionsForSelectedDay) {
      final isRestmuell = collection.type.toLowerCase().contains('restmüll');

      if (isRestmuell) {
        if (restmuellSeen) continue;
        restmuellSeen = true;
      }

      filteredCollections.add(collection);
    }
    return filteredCollections;
  }

  Widget _buildWasteCard(WasteCollection collection) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: _wasteCalenderCubit.getColorForType(collection.type),
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              (collection.type.toLowerCase().contains('restmüll')) ? 'Restmüll' : collection.type,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${collection.date.day}.${collection.date.month}.${collection.date.year}',
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
      builder: (context, state) {
        if (state is WasteCalendarLoaded) {
          final events = {
            for (var item in state.collections)
              DateTime(item.date.year, item.date.month, item.date.day): state.collections.where((e) => isSameDay(e.date, item.date)).toList()
          };

          return TableCalendar(
            locale: 'de_DE',
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              if (events[selectedDay] != null && events[selectedDay]!.isNotEmpty) {
                _scrollToValues();
              }
            },
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
              weekendTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.red : Colors.red,
              ),
              todayDecoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3,
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                fontSize: 16,
              ),
              formatButtonVisible: false,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
              weekendStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.red : Colors.red,
              ),
            ),
            eventLoader: (day) {
              return events[day] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return const SizedBox();
                return Positioned(
                  bottom: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: events.map((event) {
                      if (event is WasteCollection) {
                        return Container(
                          width: 7,
                          height: 7,
                          margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _wasteCalenderCubit.getColorForType(event.type),
                          ),
                        );
                      }
                      return const SizedBox();
                    }).toList(),
                  ),
                );
              },
            ),
          );
        }
        return TableCalendar(
          firstDay: DateTime.utc(2020, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(color: Colors.red),
            todayDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 3,
          ),
          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
            formatButtonVisible: false,
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }

  void _showLocationDialog(BuildContext context) {
    final TextEditingController typeAheadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wähle deinen Ort'),
          content: TypeAheadField(
            builder: (context, typeAheadController, focusNode) {
              return TextField(
                controller: typeAheadController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  hintText: 'Straßennamen eingeben',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              );
            },
            itemBuilder: (context, WasteLocation suggestion) {
              return ListTile(
                title: Text(suggestion.name),
              );
            },
            suggestionsCallback: (pattern) {
              if (pattern.isEmpty) {
                return locations;
              }
              return locations.where((item) => item.name.toLowerCase().contains(pattern.toLowerCase())).toList();
            },
            onSelected: (WasteLocation suggestion) async {
              typeAheadController.text = suggestion.name;
              _selectLocation(suggestion.id.toString(), suggestion.name, suggestion.hashedStreetName);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
