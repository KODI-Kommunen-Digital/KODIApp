// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/presentation/main/waste_calendar/waste_main/cubit/waste_calendar_cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/widget/app_multi_select_typeahead.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }


  Future<void> _initializeRepository() async {
    final prefs = await Preferences.openBox();
    repository = WasteCalendarRepository(prefs);
    await _loadLocations();
    await _loadWasteTypes(); // Load waste types immediately
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

  Future<void> _skipIntro() async {
    final prefs = await Preferences.openBox();
    // Set a flag to indicate the intro was skipped
    await prefs.setKeyValue(Preferences.introSkipped, true);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _selectLocation(String locationId, String locationName, String hashedStreetName) {
    setState(() {
      _selectedLocationId = locationId;
      _selectedLocationName = locationName;
      _selectedHashedStreetName = hashedStreetName;
      _showWasteTypeSelection = true;
      typeAheadController.text = locationName;
    });
  }

  void _selectWasteTypes(List<WasteType> wasteTypes) {
    setState(() {
      selectedWasteTypes = wasteTypes;
    });
  }

  void _confirmSelection() async {
    if (_selectedLocationId == null || _selectedLocationName == null || _selectedHashedStreetName == null || selectedWasteTypes.isEmpty) {
      return;
    }

    setState(() {
      _isConfirming = true;
    });

    try {
      // Use common subscription method
      await repository.updateSubscription(
        navigatorKey: navigatorKey,
        cityId: 1,
        locationId: _selectedLocationId,
        locationName: _selectedLocationName,
        hashedStreetName: _selectedHashedStreetName,
        wasteTypeIds: selectedWasteTypes.map((type) => type.id).toList(),
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
              TypeAheadField(
                controller: typeAheadController,
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: 'Straßennamen eingeben',
                      border: const OutlineInputBorder(),
                      suffixIcon: _selectedLocationId != null
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                controller.clear();
                                setState(() {
                                  _selectedLocationId = null;
                                  _selectedLocationName = null;
                                  _selectedHashedStreetName = null;
                                  _showWasteTypeSelection = false;
                                  selectedWasteTypes.clear();
                                });
                              },
                            )
                          : const Icon(Icons.arrow_drop_down),
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  if (pattern.isEmpty) {
                    return locations;
                  }
                  return locations.where((item) => item.name.toLowerCase().contains(pattern.toLowerCase())).toList();
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
                ElevatedButton(
                  onPressed: selectedWasteTypes.isNotEmpty && !_isConfirming
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
                const SizedBox(height: 10),
              ],
              TextButton(
                onPressed: _skipIntro,
                child: const Text('Überspringen'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Wenn du deinen Standort und deine Abfallarten wählst und Push-Benachrichtigungen aktivierst, erhältst du Benachrichtigungen, wann der Müll rausgebracht werden muss. Andernfalls kannst du beides später auf der Seite des Abfallkalenders ändern.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
