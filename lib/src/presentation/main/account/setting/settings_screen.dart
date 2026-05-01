// ignore_for_file: use_build_context_synchronously
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:heidi/main_prod.dart';
import 'package:heidi/src/data/remote/api/firebase_api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/configs/theme.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../data/repository/waste_calendar_repository.dart';
import '../../../../utils/common.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.user});

  final UserModel? user;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {

  late Preferences _prefs;

  bool _receiveNotification = true;
  bool _receiveWasteCalendarNotification = true;
  bool isNotificationsProgress = false;
  bool darkModeEnabled = true;
  late WasteCalendarRepository repository;


  Future<void> initializePreferences() async {
    final permission = await _prefs.getKeyValue(
        Preferences.pushNotificationsPermission, 'notAsked');
    final isAuthorized = permission == 'authorized';
    final receiveNotification =
    await _prefs.getKeyValue(Preferences.receiveNotification, isAuthorized ? 'true' : 'false');
    // Always default to 'false' — user must explicitly opt-in to waste calendar notifications
    final receiveWasteCalendar =
    await _prefs.getKeyValue(Preferences.receiveWasteCalendarNotification, 'false');

    setState(() {
      _receiveNotification = isAuthorized && receiveNotification == 'true';
      _receiveWasteCalendarNotification =
          _receiveNotification && receiveWasteCalendar == 'true';
    });

    repository = WasteCalendarRepository(_prefs);

    await repository.subscribeForWasteNotification(
        _receiveNotification && receiveWasteCalendar == 'true');
  }

  Future<void> updateNotificationPermissionPreference(bool enabled) async {
    if (isNotificationsProgress) return;

    setState(() => isNotificationsProgress = true);

    try {
      final permission = await _prefs.getKeyValue(
        Preferences.pushNotificationsPermission,
        'notAsked',
      );

      if (permission == 'denied') {
        _showPermissionDialog();
        await checkNotificationPermissionStatus();

        if (!mounted) return;

        setState(() {
          _receiveNotification = false;
          _receiveWasteCalendarNotification = false;
        });
        return;
      }

      await _prefs.setKeyValue(
          Preferences.receiveNotification, enabled ? 'true' : 'false');

      // When disabling general notifications, also turn off waste calendar.
      // When enabling, preserve the user's explicit waste calendar preference.
      if (!enabled) {
        await _prefs.setKeyValue(
            Preferences.receiveWasteCalendarNotification, 'false');
      }

      if (!mounted) return;

      setState(() {
        _receiveNotification = enabled;
        if (!enabled) {
          _receiveWasteCalendarNotification = false;
        }
      });

      await FirebaseApi(globalNavKey, _prefs).refreshNotifications();
      await repository.subscribeForWasteNotification(_receiveWasteCalendarNotification);

      if (enabled && _receiveWasteCalendarNotification && mounted) {
        Utils.showWasteNotificationSnackBar(context);
      }
    } catch (e, s) {
      debugPrint('Notification update error: $e');
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
        content: Text(
            Translate.of(context).translate('notificationPermission')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Translate.of(context).translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openApplicationSettings();
            },
            child: Text(Translate.of(context).translate('openSettings')),
          ),
        ],
      ),
    );
  }

  Future<void> updateWasteCalendarNotificationPermissionPreference(bool enabled) async {
    if (!_receiveNotification) return;

    if (isNotificationsProgress) return;

    setState(() => isNotificationsProgress = true);

    try {
      await _prefs.setKeyValue(
        Preferences.receiveWasteCalendarNotification,
        enabled ? 'true' : 'false',
      );

      if (!mounted) return;

      setState(() => _receiveWasteCalendarNotification = enabled);

      await repository
          .subscribeForWasteNotification(_receiveWasteCalendarNotification);

      if (enabled && mounted) {
        Utils.showWasteNotificationSnackBar(context);
      }
    } catch (e, s) {
      debugPrint('Waste calendar notification error: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      if (!mounted) return;
      setState(() => isNotificationsProgress = false);
    }
  }


  Future<void> checkNotificationPermissionStatus() async {
    final settings =
    await FirebaseMessaging.instance.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _prefs.setKeyValue(
          Preferences.pushNotificationsPermission, 'authorized');
    } else {
      await _prefs.setKeyValue(
          Preferences.pushNotificationsPermission, 'denied');

      setState(() {
        _receiveNotification = false;
        _receiveWasteCalendarNotification = false;
      });
    }
  }


  Future<void> openApplicationSettings() async {
    final bool opened = await openAppSettings(); // plugin method
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open app settings')),
      );
    }
  }

  Future<String> getAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<void> switchTheme() async {
    final prefBox = await Preferences.openBox();

    DarkOption darkOption =
        darkModeEnabled ? DarkOption.alwaysOn : DarkOption.alwaysOff;
    String darkOptionValue = darkModeEnabled ? 'on' : 'off';

    await prefBox.setKeyValue(Preferences.darkOption, darkOptionValue);
    AppBloc.themeCubit.onChangeTheme(darkOption: darkOption);
  }

  Future<void> isDarkMode() async {
    final prefBox = await Preferences.openBox();
    String darkMode = await prefBox.getKeyValue(Preferences.darkOption, 'on');
    setState(() {
      darkModeEnabled = (darkMode == 'on');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    _prefs = await Preferences.openBox();
    await isDarkMode();
    await initializePreferences();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkNotificationPermissionStatus();
    }
  }

  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isNotificationsProgress,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('setting'),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: <Widget>[
                  AppListTitle(
                    title: Translate.of(context).translate('notification'),
                    trailing: CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: _receiveNotification,
                      onChanged: updateNotificationPermissionPreference,
                    ),
                  ),

                  AppListTitle(
                    title: Translate.of(context)
                        .translate('waste_calendar_notification'),
                    trailing: CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: _receiveWasteCalendarNotification,
                      onChanged: _receiveNotification
                          ? updateWasteCalendarNotificationPermissionPreference
                          : null, // 🔒 disabled if master off
                    ),
                  ),
                  AppListTitle(
                    title: "Dark Mode",
                    trailing: CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          darkModeEnabled = value;
                          switchTheme();
                        });
                      },
                    ),
                  ),
                  if (widget.user != null)
                    AppListTitle(
                      title: Translate.of(context).translate('profile_settings'),
                      onPressed: () {
                        _onNavigate(Routes.profileSettings);
                      },
                      trailing: Row(
                        children: <Widget>[
                          RotatedBox(
                            quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  AppListTitle(
                    title: Translate.of(context).translate('version'),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Ensures space between items
                      children: <Widget>[
                        FutureBuilder<String>(
                          future:
                          getAppVersion(), // This needs to be your method to get the app version
                          builder:
                              (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!, // Display the version number
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isNotificationsProgress) ...[
                const ModalBarrier(
                  dismissible: false,
                  color: Colors.black54,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      const SizedBox(height: 20,),
                      Text(Translate.of(context).translate('saving_changes'))
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
