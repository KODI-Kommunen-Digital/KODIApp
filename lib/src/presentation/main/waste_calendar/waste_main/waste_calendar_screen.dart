// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../utils/translate.dart';
import 'cubit/waste_calendar_cubit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';
import 'package:heidi/src/presentation/widget/app_multi_select_typeahead.dart';
import 'package:heidi/src/presentation/widget/custom_webview.dart';
import 'package:heidi/src/presentation/widget/loading_dialog.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

Color _colorFromHex(String hex) {
  try {
    final hexCode = hex.replaceFirst('#', '');
    if (hexCode.length == 6) return Color(int.parse('FF$hexCode', radix: 16));
    if (hexCode.length == 8) return Color(int.parse(hexCode, radix: 16));
  } catch (_) {}
  return Colors.grey;
}

Widget _buildWasteIcon(String imageUrl, String colourHex, double size) {
  final color = _colorFromHex(colourHex);
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      shape: BoxShape.circle,
    ),
    padding: EdgeInsets.all(size * 0.18),
    // child: CachedNetworkImage(
    //   imageUrl: '${Application.picturesURL}$imageUrl',
    //   color: color,
    //   colorBlendMode: BlendMode.srcIn,
    //   placeholder: (_, __) => Icon(Icons.delete, color: color, size: size * 0.5),
    //   errorWidget: (_, __, ___) => Icon(Icons.delete, color: color, size: size * 0.5),
    // ),
      child: SvgPicture.network(
        '${Application.picturesURL}$imageUrl',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        placeholderBuilder: (context) => Icon(
          Icons.delete_outline,
          color: color,
          size: 18,
        ),
      )
  );
}

class WasteCalendar extends StatefulWidget {
  const WasteCalendar({super.key});

  @override
  _WasteCalendarState createState() => _WasteCalendarState();
}

class _WasteCalendarState extends State<WasteCalendar>
    with WidgetsBindingObserver {
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
  Preferences? prefs;
  bool _receiveNotification = false;
  bool _receiveWasteCalendarNotification = false;
  bool isNotificationsProgress = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await Preferences.openBox();
      if (prefs != null) {
        final permission = await prefs!.getKeyValue(
            Preferences.pushNotificationsPermission, 'notAsked');
        final isAuthorized = permission == 'authorized';
        // Always default to 'false' — user must explicitly opt-in
        receiveWasteCalendarNotification = prefs!.getKeyValue(
          Preferences.receiveWasteCalendarNotification,
          'false',
        );
      }
      await _initNotificationState();
      _initializeRepository();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermissionStatus();
    }
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

    if (savedWasteTypeIds.isEmpty) {
      setState(() {
        selectedWasteTypes = [];
      });
    } else {
      if (wasteTypes.isEmpty) {
        await _loadWasteTypes();
      }

      setState(() {
        selectedWasteTypes = wasteTypes
            .where((type) => savedWasteTypeIds.contains(type.id))
            .toList();
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
    final prefs = await Preferences.openBox();

    List<int> selectedWasteTypesIds = prefs.getSelectedWasteTypes();

    setState(() {
      _selectedLocationId = locationId;
      _selectedLocationName = locationName;
    });

    await repository.updateSubscription(
      navigatorKey: navigatorKey,
      cityId: 1,
      locationId: locationId,
      locationName: locationName,
      wasteTypeIds: selectedWasteTypesIds,
      hashedStreetName: hashedStreetName,
        onSuccess: () async {
          final prefs = await Preferences.openBox();
          // Preserve the user's existing waste calendar preference — never auto-enable
          final currentWasteCalPref = prefs.getKeyValue(
            Preferences.receiveWasteCalendarNotification, 'false');

          setState(() {
            receiveWasteCalendarNotification = currentWasteCalPref;
          });
          await repository.subscribeForWasteNotification(
            _receiveNotification && currentWasteCalPref == 'true');
          _initializeRepository();
        });
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
                              onPressed: () async {
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

                                          // Preserve the user's existing preference — never auto-enable
                                          final currentWasteCalPref =
                                              prefs.getKeyValue(
                                                  Preferences
                                                      .receiveWasteCalendarNotification,
                                                  'false');

                                          setState(() {
                                            receiveWasteCalendarNotification =
                                                currentWasteCalPref;
                                          });

                                          await repository
                                              .subscribeForWasteNotification(
                                                  _receiveNotification &&
                                                      currentWasteCalPref ==
                                                          'true');
                                          _initializeRepository();
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

  Future<void> _initNotificationState() async {
    if (prefs == null) return;
    final permission = await prefs!.getKeyValue(
        Preferences.pushNotificationsPermission, 'notAsked');
    final isAuthorized = permission == 'authorized';
    final receiveNotification = prefs!.getKeyValue(
        Preferences.receiveNotification, isAuthorized ? 'true' : 'false');
    // Always default to 'false' — user must explicitly opt-in
    final receiveWasteCalendar = prefs!.getKeyValue(
        Preferences.receiveWasteCalendarNotification, 'false');

    if (!mounted) return;
    setState(() {
      _receiveNotification = isAuthorized && receiveNotification == 'true';
      _receiveWasteCalendarNotification =
          _receiveNotification && receiveWasteCalendar == 'true';
    });
  }

  Future<void> _updateWasteCalendarNotification(bool enabled) async {
    if (!_receiveNotification || isNotificationsProgress || prefs == null) return;

    setState(() => isNotificationsProgress = true);

    try {
      final permission = await prefs!.getKeyValue(
          Preferences.pushNotificationsPermission, 'notAsked');

      if (permission == 'denied') {
        _showPermissionDialog();
        await _checkNotificationPermissionStatus();
        if (!mounted) return;
        setState(() => _receiveWasteCalendarNotification = false);
        return;
      }

      await prefs!.setKeyValue(
        Preferences.receiveWasteCalendarNotification,
        enabled ? 'true' : 'false',
      );

      if (!mounted) return;
      setState(() {
        _receiveWasteCalendarNotification = enabled;
        receiveWasteCalendarNotification = enabled ? 'true' : 'false';
      });

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
    if (prefs == null) return;
    final settings =
        await FirebaseMessaging.instance.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await prefs!
          .setKeyValue(Preferences.pushNotificationsPermission, 'authorized');
    } else {
      await prefs!
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
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withOpacity(0.6),
      child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Translate.of(context)
                .translate('waste_calendar_push_toggle_title'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
                    Translate.of(context).translate('toggle_disable'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: !_receiveWasteCalendarNotification
                          ? Colors.black87
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoSwitch(
                    activeColor: Theme.of(context).primaryColor,
                    value: _receiveWasteCalendarNotification,
                    onChanged: _receiveNotification
                        ? _updateWasteCalendarNotification
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    Translate.of(context).translate('toggle_enable'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _receiveWasteCalendarNotification
                          ? Theme.of(context).primaryColor
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> selectedWasteTypes =
        (prefs != null) ? prefs!.getSelectedWasteTypes() : [];
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
                        _showLocationDialog(context);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.recycling),
                    onPressed: () {
                      if (!isLoading) {
                        _showWasteTypeDialog(context);
                      }
                    },
                  ),
                ],
              ),
              body: BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
                builder: (context, state) {
                  final isPageLoading =
                      isDataInitializing || state is WasteCalendarLoading;
                  return Stack(
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
                                // SizedBox(
                                //   height: 200,
                                //   child: Stack(
                                //     children: [
                                //       ClipRRect(
                                //         borderRadius:
                                //             BorderRadius.circular(15.0),
                                //         child: Opacity(
                                //           opacity: 0.3,
                                //           child: Image.asset(
                                //             "assets/images/garbage.jpg",
                                //             fit: BoxFit.cover,
                                //             width: double.infinity,
                                //             height: double.infinity,
                                //           ),
                                //         ),
                                //       ),
                                //       Center(
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             Text(
                                //               "${_selectedDay.day} ${_selectedDay.monthName()}",
                                //               style: const TextStyle(
                                //                   fontSize: 22,
                                //                   color: Colors.red),
                                //             ),
                                //             Text(
                                //               _selectedDay.weekdayName(),
                                //               style: const TextStyle(
                                //                   fontSize: 32,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(height: 16),
                                const Text("Nächste Abholungen",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                BlocBuilder<WasteCalendarCubit,
                                    WasteCalendarState>(
                                  builder: (context, state) {
                                    if (state is WasteCalendarLoaded) {
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
                                                child: Text(
                                                    (selectedWasteTypes.isNotEmpty) ?
                                                    Translate.of(
                                                        context)
                                                    .translate(
                                                        'no_pickups_scheduled') :
                                                    Translate.of(
                                                        context)
                                                        .translate(
                                                        'no_waste_type_selected')
                                                ),
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
                                _buildNotificationToggle(),
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
                                                  leading: _buildWasteIcon(collection.image, collection.colour, 40),
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
                                const SizedBox(height: 24),
                                Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(14),
                                  shadowColor: Colors.black.withOpacity(0.6),
                                  child: InkWell(
                                  onTap: () {
                                    CustomWebViewScreen.showAsBottomSheet(
                                      context: context,
                                      url: 'https://www.rsag.de/',
                                      title: 'RSAG',
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 72,
                                          height: 56,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/rsag-logo.svg',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                Translate.of(context).translate('rsag_card_title'),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                Translate.of(context).translate('rsag_card_subtitle'),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 100)),
                              ],
                            ),
                          ),
                        ),

                        if (isPageLoading) ...[
                          Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          const Center(child: CircularProgressIndicator.adaptive()),
                        ],
                        if (isLoading) ...[
                          GestureDetector(
                            onTap: () {},
                            onPanDown: (_) {},
                            child: Container(
                              color: Colors.black54,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
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
                    );
                  },
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
            _buildWasteIcon(collection.image, collection.colour, 48),
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
            availableGestures: AvailableGestures.horizontalSwipe,
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
              markersMaxCount: 4,
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
                  uniqueColors.add(_colorFromHex(event.colour));
                }

                // Take only first 4 unique colors
                final colorsToShow = uniqueColors.take(4).toList();

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
        return const SizedBox.shrink();
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
