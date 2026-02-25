// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/presentation/main/waste_calendar/waste_main/cubit/waste_calendar_cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/widget/app_multi_select_typeahead.dart';

import '../../utils/translate.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  final TextEditingController typeAheadController = TextEditingController();

  List<WasteLocation> locations = [];
  List<WasteType> wasteTypes = [];
  List<WasteType> selectedWasteTypes = [];
  late WasteCalendarRepository repository;
  final _wasteCalenderCubit = WasteCalendarCubit();
  String? _selectedLocationId;
  String? _selectedLocationName;
  String? _selectedHashedStreetName;
  bool _showWasteTypeSelection = false;
  bool _isConfirming = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isLocationsLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  @override
  void dispose() {
    typeAheadController.dispose();
    _wasteCalenderCubit.close();
    super.dispose();
  }

  Future<void> _initializeRepository() async {
    final prefs = await Preferences.openBox();
    repository = WasteCalendarRepository(prefs);
    await _loadLocations();
    await _loadWasteTypes(); // Load waste types immediately
  }

  Future<void> _loadLocations() async {
    final fetchedLocations = await repository.loadWasteCalendarStreets(1);
    if (mounted) {
      setState(() {
        locations = fetchedLocations ?? [];
        _isLocationsLoading = false;
      });
    }
  }

  Future<void> _loadWasteTypes() async {
    final fetchedWasteTypes = await repository.loadWasteTypes(1);
    if (mounted) {
      setState(() {
        if (fetchedWasteTypes != null) {
          wasteTypes = fetchedWasteTypes;
        }
      });
    }
  }

  Future<void> _skipIntro() async {
    final prefs = await Preferences.openBox();
    // Set a flag to indicate the intro was skipped
    await prefs.setKeyValue(Preferences.introSkipped, true);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _selectLocation(String locationId, String locationName, String hashedStreetName) {
    if (mounted) {
      setState(() {
        _selectedLocationId = locationId;
        _selectedLocationName = locationName;
        _selectedHashedStreetName = hashedStreetName;
        _showWasteTypeSelection = true;
        typeAheadController.text = locationName;
      });
    }
  }

  void _selectWasteTypes(List<WasteType> wasteTypes) {
    if (mounted) {
      setState(() {
        selectedWasteTypes = wasteTypes;
      });
    }
  }

  void _confirmSelection() async {
    if (_selectedLocationId == null || _selectedLocationName == null || _selectedHashedStreetName == null) {
      return;
    }

    if (mounted) {
      setState(() {
        _isConfirming = true;
      });
    }

    try {
      // Use common subscription method
      await repository.updateSubscription(
        navigatorKey: navigatorKey,
        cityId: 1,
        locationId: _selectedLocationId,
        locationName: _selectedLocationName,
        hashedStreetName: _selectedHashedStreetName,
        wasteTypeIds: selectedWasteTypes.map((type) => type.id).toList(),
        onSuccess: (){}
      );

      _wasteCalenderCubit.updateStreetId(_selectedLocationId!, selectedWasteTypeIds: selectedWasteTypes.map((type) => type.id).toList());
      Navigator.pushReplacementNamed(context, '/home');
    } finally {
      if (mounted) {
        setState(() {
          _isConfirming = false;
        });
      }
    }
  }

  void _wasteCalendarSkipped() async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(
        Preferences.receiveWasteCalendarNotification, 'false');
    await prefs.setBool(Preferences.isWasteCalendarSkipped, true);
    await repository.subscribeForWasteNotification(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ort und Abfallart auswählen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
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
                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wähle deinen Ort',
                            style: TextStyle(fontSize: 22, color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Und deine Abfallarten',
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TypeAheadField<WasteLocation>(
                controller: typeAheadController,
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    enabled: !_isLocationsLoading,
                    decoration: InputDecoration(
                      hintText: 'Straßennamen eingeben',
                      border: const OutlineInputBorder(),
                      suffixIcon: _selectedLocationId != null
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                controller.clear();
                                if (mounted) {
                                  setState(() {
                                    _selectedLocationId = null;
                                    _selectedLocationName = null;
                                    _selectedHashedStreetName = null;
                                    _showWasteTypeSelection = false;
                                    selectedWasteTypes.clear();
                                  });
                                }
                              },
                            )
                          : const Icon(Icons.arrow_drop_down),
                    ),
                  );
                },
                suggestionsCallback: (String pattern) async {
                  if (pattern.isEmpty) {
                    final sorted = [...locations];
                    sorted.sort((a, b) => a.name.compareTo(b.name));
                    return sorted;
                  }

                  final query = pattern.toLowerCase();

                  final filtered = locations
                      .where((item) => item.name.toLowerCase().contains(query))
                      .toList();

                  filtered.sort((a, b) {
                    final aName = a.name.toLowerCase();
                    final bName = b.name.toLowerCase();

                    final aStarts = aName.startsWith(query);
                    final bStarts = bName.startsWith(query);

                    // Priority 1: startsWith
                    if (aStarts && !bStarts) return -1;
                    if (!aStarts && bStarts) return 1;

                    // Priority 2: alphabetical order
                    return aName.compareTo(bName);
                  });

                  return filtered;
                },
                itemBuilder: (context, WasteLocation suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                  );
                },
                onSelected: (WasteLocation suggestion) async {
                  // unfocus through context
                  FocusScope.of(context).unfocus();
                  typeAheadController.text = suggestion.name;
                  _selectLocation(suggestion.id.toString(), suggestion.name, suggestion.hashedStreetName);
                },
              ),
              const SizedBox(height: 20),
              if (_showWasteTypeSelection) ...[
                AppMultiSelectTypeAhead(
                  items: wasteTypes,
                  selectedItems: selectedWasteTypes,
                  onSelectionChanged: (selectedTypes) {
                        _selectWasteTypes(selectedTypes);
                      },
                  hintText: 'Abfallarten eingeben',
                  enabled: !_isConfirming,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _wasteCalendarSkipped();
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Überspringen'),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: !_isConfirming
                          ? _confirmSelection
                          : null,
                      child: _isConfirming
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Bestätigen'),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
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
                )
              ],
              const SizedBox(height: 10),
              Text(
                Translate.of(context)
                    .translate('waste_calendar_push_notification_info'),
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              if(!_showWasteTypeSelection)
              TextButton(
                onPressed: () {
                  _wasteCalendarSkipped();
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Überspringen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
