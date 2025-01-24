// ignore_for_file: use_build_context_synchronously
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.user});

  final UserModel? user;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  late final Preferences prefs;
  late final String pushNotificationsPermission;
  bool darkModeEnabled = true;

  Future<void> openAppSettings() async {
    if (!await launchUrl(Uri.parse('app-settings:'))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to open app settings.'),
      ));
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
    isDarkMode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('setting'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
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
      ),
    );
  }
}
