// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/remote/api/firebase_api.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/main/waste_calendar/waste_main/cubit/waste_calendar_cubit.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import '../../utils/street_name_hash.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  final TextEditingController typeAheadController = TextEditingController();
  List<WasteLocation> locations = [];
  late WasteCalendarRepository repository;
  final _wasteCalenderCubit = WasteCalendarCubit();
  String? _selectedLocationId;
  String? _selectedLocationName;
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
  }

  Future<void> _loadLocations() async {
    try {
      final fetchedLocations = await repository.loadWasteCalendarStreets(1);
      setState(() {
        if (fetchedLocations != null) {
          locations = fetchedLocations;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Standorte konnten nicht geladen werden. Bitte versuchen Sie es später noch einmal.")));
    }
  }

  void _selectLocation(String locationId, String locationName, String hashedStreetName) async {
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
    // if (previousLocationId != null) {
    //   final previousTopic =
    //       repository.getTopicString(int.parse(previousLocationId));
    //   await firebaseApi.unsubscribeFromTopic(previousTopic);
    // }

    // final newTopic = repository.getTopicString(int.parse(locationId));

    final newTopic =
        repository.getTopicFromHash(hashedStreetName);
    await firebaseApi.subscribeToTopic(newTopic);

    // final streetId = int.parse(locationId);
    _wasteCalenderCubit.updateStreetId(locationId);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ort auswählen'),
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
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Für Müllabfuhrmeldungen',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TypeAheadField(
                builder: (context, typeAheadController, focusNode) {
                  return TextField(
                    controller: typeAheadController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Straßennamen eingeben',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  //return locations;
                  return locations
                      .where((item) => item.name
                          .toLowerCase()
                          .startsWith(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, WasteLocation suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                  );
                },
                onSelected: (WasteLocation suggestion) async {
                  typeAheadController.text = suggestion.name;
                  _selectLocation(suggestion.id.toString(), suggestion.name,suggestion.hashedStreetName);
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Überspringen'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Wenn du diesen Standort wählst und Push-Benachrichtigungen aktivierst, erhältst du Benachrichtigungen, wann der Müll rausgebracht werden muss. Andernfalls kannst du den Ort später auf der Seite des Abfallkalenders ändern.',
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
