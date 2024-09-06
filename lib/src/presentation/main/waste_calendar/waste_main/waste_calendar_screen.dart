// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:heidi/src/data/remote/api/firebase_api.dart';
import 'package:table_calendar/table_calendar.dart';
import 'cubit/waste_calendar_cubit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';

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
    _loadLocation();
  }

  Future<void> _loadLocations() async {
    final fetchedLocations = await repository.loadWasteCalendarStreets(1);
    setState(() {
      if (fetchedLocations != null) {
        locations = fetchedLocations;
      }
    });
  }

  Future<void> _loadLocation() async {
    final prefs = await Preferences.openBox();
    setState(() {
      _selectedLocationId =
          prefs.getKeyValue(Preferences.selectedLocationId, null);
      _selectedLocationName =
          prefs.getKeyValue(Preferences.selectedLocationName, null);
      if (_selectedLocationId == null) {
        _showLocationDialog(context);
      } else {
        _wasteCalenderCubit.loadWasteCollections(1, _selectedLocationId);
      }
    });
  }

  void _selectLocation(String locationId, String locationName) async {
    final prefs = await Preferences.openBox();
    final previousLocationId =
        prefs.getKeyValue(Preferences.selectedLocationId, null);
    await prefs.setKeyValue(Preferences.selectedLocationId, locationId);
    await prefs.setKeyValue(Preferences.selectedLocationName, locationName);
    setState(() {
      _selectedLocationId = locationId;
      _selectedLocationName = locationName;
    });

    final firebaseApi = FirebaseApi(navigatorKey, prefs);
    if (previousLocationId != null) {
      final previousTopic =
          repository.getTopicString(int.parse(previousLocationId));
      await firebaseApi.unsubscribeFromTopic(previousTopic);
    }

    final newTopic = repository.getTopicString(int.parse(locationId));
    await firebaseApi.subscribeToTopic(newTopic);

    // final streetId = int.parse(locationId);
    _wasteCalenderCubit.updateStreetId(locationId);
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
          title: Text(_selectedLocationName ?? 'Straße auswählen'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                _showLocationDialog(context);
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
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.red),
                            ),
                            Text(
                              _selectedDay.weekdayName(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Nächste Abholungen",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            return _buildWasteCard(
                                state.carouselCollections[index]);
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
                  builder: (context, state) {
                    if (state is WasteCalendarLoaded) {
                      final collectionsForSelectedDay = state.collections
                          .where((collection) =>
                              isSameDay(collection.date, _selectedDay))
                          .toList();
                      if (collectionsForSelectedDay.isEmpty) {
                        return const Text(
                            "Keine Abholungen für den ausgewählten Tag verfügbar");
                      }
                      return Column(
                        children: collectionsForSelectedDay
                            .map((collection) => ListTile(
                                  leading: Icon(Icons.delete,
                                      color: _wasteCalenderCubit
                                          .getColorForType(collection.type)),
                                  title: Text(collection.type),
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
              collection.type,
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
              DateTime(item.date.year, item.date.month, item.date.day): state
                  .collections
                  .where((e) => isSameDay(e.date, item.date))
                  .toList()
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
              if (events[selectedDay] != null &&
                  events[selectedDay]!.isNotEmpty) {
                _scrollToValues();
              }
            },
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              weekendTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.red
                    : Colors.red,
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3,
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
              ),
              formatButtonVisible: false,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              weekendStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.red
                    : Colors.red,
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
                            color:
                                _wasteCalenderCubit.getColorForType(event.type),
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
              return locations.where((item) =>
                                 item.name.toLowerCase().startsWith(pattern.toLowerCase())).toList();
            },
            onSelected: (WasteLocation suggestion) async {
              typeAheadController.text = suggestion.name;
              _selectLocation(suggestion.id.toString(), suggestion.name);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
