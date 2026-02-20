// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../utils/translate.dart';
import 'cubit/waste_calendar_cubit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/widget/app_multi_select_typeahead.dart';
import 'package:heidi/src/presentation/widget/loading_dialog.dart';

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
  late String receiveWasteCalendarNotification;
  bool isLoading = false;
  bool isDataInitializing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await Preferences.openBox();
      final permission = await prefs.getKeyValue(
          Preferences.pushNotificationsPermission, 'notAsked');
      final isAuthorized = permission == 'authorized';
      receiveWasteCalendarNotification = prefs.getKeyValue(
        Preferences.receiveWasteCalendarNotification,
        isAuthorized ? 'true' : 'false',
      );
      _initializeRepository();
    });
  }

  void _showNotificationEnableDialog({required bool isWasteTypeEmpty}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(Translate.of(context)
              .translate('enable_waste_calendar_notification_title')),
          content: Text(Translate.of(context)
              .translate('enable_waste_calendar_notification_desc')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (isWasteTypeEmpty) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeRepository() async {
    setState(() => isDataInitializing = true);

    try {
      final prefs = await Preferences.openBox();
      final previousWasteTypes = prefs.getSelectedWasteTypes();

      // if (receiveWasteCalendarNotification == 'false' &&
      //     previousWasteTypes.isEmpty) {
      //   _showNotificationEnableDialog(isWasteTypeEmpty: true);
      //   return;
      // }

      repository = WasteCalendarRepository(prefs);

      await Future.wait([
        _loadLocations(),
        _loadWasteTypes(),
        _loadSelectedWasteTypes(),
      ]);

      await _loadLocation();
    } catch (e, s) {
      debugPrint('Init error: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      if (!mounted) return;
      setState(
          () => isDataInitializing = false);
    }
  }

  Future<void> _loadLocations() async {
    final fetchedLocations = await repository.loadWasteCalendarStreets(1);

    if (!mounted) return;

    setState(() {
      locations = fetchedLocations ?? [];
    });
  }

  Future<void> _loadWasteTypes() async {
    final fetchedWasteTypes = await repository.loadWasteTypes(1);
    if (!mounted) return;

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
      // Only load waste types initially if not already loaded
      if (wasteTypes.isEmpty) {
        await _loadWasteTypes();
      }

      setState(() {
        selectedWasteTypes = wasteTypes
            .where((type) => savedWasteTypeIds.contains(type.id))
            .toList();
      });
    } else {
      setState(() {
        selectedWasteTypes = [];
      });
    }
  }

  Future<void> _loadLocation() async {
    final prefs = await Preferences.openBox();

    if (!mounted) return;

    final locationId = prefs.getKeyValue(Preferences.selectedLocationId, null);
    final locationName =
        prefs.getKeyValue(Preferences.selectedLocationName, null);

    if (locationId == null) {
      _showLocationDialog(context);
      return;
    }

    setState(() {
      _selectedLocationId = locationId;
      _selectedLocationName = locationName;
    });

    _wasteCalenderCubit.loadWasteCollections(
      1,
      locationId,
      selectedWasteTypeIds: selectedWasteTypes.map((type) => type.id).toList(),
    );
  }

  Future<void> _selectLocation(
      String locationId, String locationName, String hashedStreetName) async {
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
        onSuccess: (){
          _initializeRepository();
        }
    );

    _wasteCalenderCubit.updateStreetId(locationId,
        selectedWasteTypeIds:
            selectedWasteTypes.map((type) => type.id).toList());
  }

  void _selectWasteTypes(List<WasteType> wasteTypes) {
    setState(() {
      selectedWasteTypes = wasteTypes;
    });
  }

  Future<void> _updateWasteTypesSubscription({required Function() onSuccess}) async {
    if (selectedWasteTypes.isNotEmpty) {
      await repository.updateSubscription(
        navigatorKey: navigatorKey,
        cityId: 1,
        wasteTypeIds: selectedWasteTypes.map((type) => type.id).toList(),
          onSuccess: (){
            _initializeRepository();
            onSuccess();
          }
      );
    }
  }

  void _showWasteTypeDialog(BuildContext parentContext) {
    // Create local copy of selected waste types for the dialog
    List<WasteType> localSelectedWasteTypes = List.from(selectedWasteTypes);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
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
                          selectedItems: localSelectedWasteTypes,
                          onSelectionChanged: (selectedTypes) {
                            setDialogState(() {
                              localSelectedWasteTypes = selectedTypes;
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
                              onPressed: localSelectedWasteTypes.isEmpty
                                  ? null
                                  : () async {
                                      _selectWasteTypes(
                                          localSelectedWasteTypes);
                                      final loadingDialog = LoadingDialog();
                                      loadingDialog.show(
                                        parentContext,
                                        'Bitte warten, während wir abonnieren...',
                                      );
                                      try {
                                        await _updateWasteTypesSubscription(
                                            onSuccess: () async {
                                          final prefs =
                                              await Preferences.openBox();

                                          final permission =
                                              await prefs.getKeyValue(
                                                  Preferences
                                                      .pushNotificationsPermission,
                                                  'notAsked');
                                          final isAuthorized =
                                              permission == 'authorized';
                                          await prefs.setKeyValue(
                                              Preferences
                                                  .receiveWasteCalendarNotification,
                                              isAuthorized ? 'true' : 'false');

                                          setState(() {
                                            receiveWasteCalendarNotification =
                                                prefs.getKeyValue(
                                              Preferences
                                                  .receiveWasteCalendarNotification,
                                              isAuthorized ? 'true' : 'false',
                                            );
                                          });

                                          await repository
                                              .subscribeForWasteNotification(
                                                  true);
                                        });
                                        Navigator.pop(context);
                                      } finally {
                                        loadingDialog.hide(parentContext);
                                      }
                                    },
                              child: const Text('Bestätigen'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(height: 0.5,),
                            const SizedBox(height: 14),
                            Text(
                              Translate.of(context).translate('garbage_cans'),
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              Translate.of(context).translate('garbage_cans_description'),
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 0.5,),
                            const SizedBox(height: 14),
                            Text(
                              Translate.of(context).translate('waste_container'),
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              Translate.of(context).translate('waste_container_description'),
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              Translate.of(context).translate('waste_type_description'),
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 10),
                            const Divider(height: 0.5,)
                          ],
                        ),
                        const SizedBox(height: 14),
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
      child: WillPopScope(
        onWillPop: () async {
          // Prevent back button when loading
          if (isLoading || isDataInitializing) {
            return false;
          }
          return true;
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedLocationName ?? 'Straße auswählen',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (!isLoading) {
                      Navigator.pop(context);
                    }
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      if (!isLoading) {
                        if (receiveWasteCalendarNotification == 'false') {
                          _showNotificationEnableDialog(
                              isWasteTypeEmpty: false);
                        } else {
                          _showLocationDialog(context);
                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.recycling),
                    onPressed: () {
                      if (!isLoading) {
                        if (receiveWasteCalendarNotification == 'false') {
                          _showNotificationEnableDialog(
                              isWasteTypeEmpty: false);
                        } else {
                          _showWasteTypeDialog(context);
                        }
                      }
                    },
                  ),
                ],
              ),
              body: isDataInitializing
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Stack(
                      children: [
                        // Main content
                        SingleChildScrollView(
                          controller: _scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ... rest of your content remains the same
                                SizedBox(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${_selectedDay.day} ${_selectedDay.monthName()}",
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              _selectedDay.weekdayName(),
                                              style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text("Nächste Abholungen",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                BlocBuilder<WasteCalendarCubit,
                                    WasteCalendarState>(
                                  builder: (context, state) {
                                    if (state is WasteCalendarLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is WasteCalendarLoaded) {
                                      return state
                                              .carouselCollections.isNotEmpty
                                          ? SizedBox(
                                              height: 180,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: state
                                                    .carouselCollections.length,
                                                itemBuilder: (context, index) {
                                                  return _buildWasteCard(
                                                      state.carouselCollections[
                                                          index]);
                                                },
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Center(
                                                child: Text(Translate.of(
                                                        context)
                                                    .translate(
                                                        'no_pickups_scheduled')),
                                              ),
                                            );
                                    } else if (state is WasteCalendarError) {
                                      return Center(
                                          child: Text('Error: ${state.error}'));
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                BlocBuilder<WasteCalendarCubit,
                                    WasteCalendarState>(
                                  builder: (context, state) {
                                    if (state is WasteCalendarLoaded) {
                                      final collectionsForSelectedDay = state
                                          .collections
                                          .where((collection) => isSameDay(
                                              collection.date, _selectedDay))
                                          .toList();
                                      if (collectionsForSelectedDay.isEmpty) {
                                        return const Text(
                                            "Keine Abholungen für den ausgewählten Tag verfügbar");
                                      }
                                      return Column(
                                        children:
                                        collectionsForSelectedDay.map((collection) => ListTile(
                                                  leading: Icon(Icons.delete,
                                                      color: _wasteCalenderCubit
                                                          .getColorForType(
                                                              collection.type)),
                                                  title: Text(
                                                    collection.type
                                                  ),
                                                ))
                                            .toList(),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 100)),
                              ],
                            ),
                          ),
                        ),

                        // Loading overlay - This should block ALL interactions
                        if (isLoading) ...[
                          // Full-screen barrier that blocks all touches
                          GestureDetector(
                            onTap: () {},
                            onPanDown: (_) {},
                            child: Container(
                              color: Colors.black54,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),

                          // Loading indicator in center
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              constraints: const BoxConstraints(
                                maxWidth: 300,
                                minWidth: 200,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Bitte warten, während wir abonnieren...',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<WasteCollection> removeMultiples(
      List<WasteCollection> collectionsForSelectedDay) {
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
          final Map<DateTime, List<WasteCollection>> events = {};

          for (final item in state.collections) {
            final day = DateTime(item.date.year, item.date.month, item.date.day);

            if (events[day] == null) {
              events[day] = [];
            }

            events[day]!.add(item);
          }

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
              final key = DateTime(day.year, day.month, day.day);
              return events[key] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return const SizedBox();

                final wasteEvents = events.cast<WasteCollection>();

                // Extract unique colors
                final uniqueColors = <Color>{};

                for (final event in wasteEvents) {
                  final color = _wasteCalenderCubit.getColorForType(event.type);
                  uniqueColors.add(color);
                }

                // Take only first 3 unique colors
                final colorsToShow = uniqueColors.take(3).toList();

                return Positioned(
                  bottom: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: colorsToShow.map((color) {
                      return Container(
                        width: 7,
                        height: 7,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      );
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

  void _showLocationDialog(BuildContext parentContext) async {
    final prefs = await Preferences.openBox();
    final locationId = prefs.getKeyValue(Preferences.selectedLocationId, null);

    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return WillPopScope(
          onWillPop: () async {
            // If locationId is null, pop the entire screen
            if (locationId == null) {
              Navigator.of(dialogContext).pop(); // Close dialog
              Navigator.of(parentContext).pop(); // Close screen
              return false; // Don't let default behavior
            }
            return true; // Allow default back behavior
          },
          child: AlertDialog(
            title: const Text('Wähle deinen Ort'),
            content: TypeAheadField<WasteLocation>(
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    hintText: 'Straßennamen eingeben',
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                );
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion.name));
              },
              suggestionsCallback: (pattern) {
                if (pattern.isEmpty) return locations;
                return locations
                    .where((item) =>
                        item.name.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              onSelected: (WasteLocation suggestion) async {
                Navigator.pop(dialogContext);
                setState(() => isLoading = true);

                try {
                  await _selectLocation(
                    suggestion.id.toString(),
                    suggestion.name,
                    suggestion.hashedStreetName,
                  );

                  final prefs = await Preferences.openBox();
                  final previousWasteTypes = prefs.getSelectedWasteTypes();

                  if (previousWasteTypes.isEmpty && mounted) {
                    _showWasteTypeDialog(parentContext);
                  }
                } finally {
                  if (!mounted) return;
                  setState(() => isLoading = false);
                }
              },
            ),
            actions: [
              // Add a cancel button to make it clear
              TextButton(
                onPressed: () {
                  if (locationId == null) {
                    Navigator.of(dialogContext).pop();
                    Navigator.of(parentContext).pop();
                  } else {
                    Navigator.of(dialogContext).pop();
                  }
                },
                child: Text(locationId == null
                    ? Translate.of(context).translate('cancel')
                    : 'Abbrechen'),
              ),
            ],
          ),
        );
      },
    );
  }
}
