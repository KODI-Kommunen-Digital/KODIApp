import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/main/intro/intro_screen.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final prefs = await Preferences.openBox();
    final location = prefs.getKeyValue(Preferences.selectedLocationName, null);
    final wasteTypes = prefs.getSelectedWasteTypes();
    final isSkipped = prefs.getBool(Preferences.isWasteCalendarSkipped);
    final introCompleted = prefs.getBool(Preferences.introSkipped);

    if (!mounted) return;

    if ((location != null && wasteTypes.isNotEmpty) || isSkipped || introCompleted) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AppIntroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}
