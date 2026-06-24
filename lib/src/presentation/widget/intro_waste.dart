// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:heidi/src/presentation/main/waste_calendar/waste_main/cubit/waste_calendar_cubit.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/widget/app_multi_select_typeahead.dart';

import '../../utils/configs/routes.dart';
import '../../utils/translate.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage>
    with WidgetsBindingObserver {
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
  bool _isLocationsLoading = true;
  Preferences? _prefs;
  bool _receiveNotification = false;
  bool _receiveWasteCalendarNotification = false;
  bool isNotificationsProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeRepository();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    typeAheadController.dispose();
    _wasteCalenderCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermissionStatus();
    }
  }

  Future<void> _initializeRepository() async {
    _prefs = await Preferences.openBox();
    repository = WasteCalendarRepository(_prefs!);
    await _loadLocations();
    await _loadWasteTypes();
    await _initNotificationState();
  }

  Future<void> _initNotificationState() async {
    if (_prefs == null) return;
    final permission = await _prefs!.getKeyValue(
        Preferences.pushNotificationsPermission, 'notAsked');
    final isAuthorized = permission == 'authorized';
    final receiveNotification = _prefs!.getKeyValue(
        Preferences.receiveNotification, isAuthorized ? 'true' : 'false');
    final receiveWasteCalendar = _prefs!.getKeyValue(
        Preferences.receiveWasteCalendarNotification, 'false');

    if (!mounted) return;
    setState(() {
      _receiveNotification = isAuthorized && receiveNotification == 'true';
      _receiveWasteCalendarNotification =
          _receiveNotification && receiveWasteCalendar == 'true';
    });
  }

  Future<void> _updateWasteCalendarNotification(bool enabled) async {
    if (!_receiveNotification || isNotificationsProgress || _prefs == null) return;

    setState(() => isNotificationsProgress = true);

    try {
      final permission = await _prefs!.getKeyValue(
          Preferences.pushNotificationsPermission, 'notAsked');

      if (permission == 'denied') {
        _showPermissionDialog();
        await _checkNotificationPermissionStatus();
        if (!mounted) return;
        setState(() => _receiveWasteCalendarNotification = false);
        return;
      }

      await _prefs!.setKeyValue(
        Preferences.receiveWasteCalendarNotification,
        enabled ? 'true' : 'false',
      );

      if (!mounted) return;
      setState(() => _receiveWasteCalendarNotification = enabled);

      await repository.subscribeForWasteNotification(enabled);

      if (enabled && mounted) {
        Utils.showWasteNotificationSnackBar(context);
      }
    } catch (e, s) {
      debugPrint('Waste calendar notification toggle error: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      if (!mounted) return;
      setState(() => isNotificationsProgress = false);
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(Translate.of(context).translate('enableNotification')),
        content:
            Text(Translate.of(context).translate('notificationPermission')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Translate.of(context).translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _openApplicationSettings();
            },
            child: Text(Translate.of(context).translate('openSettings')),
          ),
        ],
      ),
    );
  }

  void _showWasteNotificationPermissionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            const Icon(Icons.notifications_off_outlined, color: Colors.orange),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                Translate.of(context).translate('waste_notification_permission_title'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        content: Text(
          Translate.of(context).translate('waste_notification_permission_content'),
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Translate.of(context).translate('cancel')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _openApplicationSettings();
            },
            child: Text(Translate.of(context).translate('openSettings')),
          ),
        ],
      ),
    );
  }

  Future<void> _checkNotificationPermissionStatus() async {
    if (_prefs == null) return;
    final settings =
        await FirebaseMessaging.instance.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _prefs!
          .setKeyValue(Preferences.pushNotificationsPermission, 'authorized');
    } else {
      await _prefs!
          .setKeyValue(Preferences.pushNotificationsPermission, 'denied');
      if (!mounted) return;
      setState(() {
        _receiveNotification = false;
        _receiveWasteCalendarNotification = false;
      });
    }
    await _initNotificationState();
  }

  Future<void> _openApplicationSettings() async {
    final bool opened = await openAppSettings();
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open app settings')),
      );
    }
  }

  Widget _buildNotificationToggle() {
    final theme = Theme.of(context);
    final t = Translate.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.35),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            t.translate('waste_calendar_push_toggle_title'),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.translate('toggle_disable'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: !_receiveWasteCalendarNotification
                          ? theme.colorScheme.onSurface
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoSwitch(
                    activeColor: theme.primaryColor,
                    value: _receiveWasteCalendarNotification,
                    onChanged: _receiveNotification
                        ? _updateWasteCalendarNotification
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    t.translate('toggle_enable'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _receiveWasteCalendarNotification
                          ? theme.primaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              if (!_receiveNotification)
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _showWasteNotificationPermissionDialog,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
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
    await prefs.setKeyValue(Preferences.introSkipped, true);
    await prefs.setBool(Preferences.isWasteCalendarIntroCompleted, true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.wasteCalendar);
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
      await repository.updateSubscription(
        cityId: 1,
        locationId: _selectedLocationId,
        locationName: _selectedLocationName,
        hashedStreetName: _selectedHashedStreetName,
        wasteTypeIds: selectedWasteTypes.map((type) => type.id).toList(),
        onSuccess: (){}
      );

      if (_prefs != null) {
        await _prefs!.setBool(Preferences.isWasteCalendarIntroCompleted, true);
      }

      _wasteCalenderCubit.updateStreetId(_selectedLocationId!, selectedWasteTypeIds: selectedWasteTypes.map((type) => type.id).toList());
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.wasteCalendar);
    } finally {
      if (mounted) {
        setState(() {
          _isConfirming = false;
        });
      }
    }
  }

  Future<void> _wasteCalendarSkipped() async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(
        Preferences.receiveWasteCalendarNotification, 'false');
    await prefs.setBool(Preferences.isWasteCalendarSkipped, true);
    await prefs.setBool(Preferences.isWasteCalendarIntroCompleted, true);
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
                const SizedBox(height: 20),
                _buildNotificationToggle(),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await _wasteCalendarSkipped();
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, Routes.wasteCalendar);
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
                onPressed: () async {
                  await _wasteCalendarSkipped();
                  if (!mounted) return;
                  Navigator.pushReplacementNamed(context, Routes.wasteCalendar);
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
