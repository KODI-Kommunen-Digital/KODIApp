import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/main/intro/intro_screen.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

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
    final t = Translate.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.white,
                elevation: 12,
                borderRadius: BorderRadius.circular(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      Images.logo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                t.translate('intro_tagline'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                t.translate('welcome_subtitle'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
