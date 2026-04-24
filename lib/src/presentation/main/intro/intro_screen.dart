// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';

import '../../../utils/translate.dart';

class AppIntroScreen extends StatelessWidget {
  const AppIntroScreen({super.key});

  Future<void> _testAppNow(BuildContext context) async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(
        Preferences.receiveWasteCalendarNotification, 'false');
    await prefs.setBool(Preferences.isWasteCalendarSkipped, true);
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translate.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Image.asset(Images.logo, height: 72),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      t.translate('welcome_title'),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.translate('welcome_subtitle'),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
                    _FeatureCard(
                      icon: Icons.newspaper_outlined,
                      title: t.translate('feature_news_title'),
                      description: t.translate('feature_news_description'),
                    ),
                    const SizedBox(height: 16),
                    _FeatureCard(
                      icon: Icons.delete_outline,
                      title: t.translate('feature_waste_title'),
                      description: t.translate('feature_waste_description'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    t.translate('button_setup_waste_calendar'),
                    mainAxisSize: MainAxisSize.max,
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, Routes.introWaste),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    t.translate('button_test_app'),
                    type: ButtonType.outline,
                    mainAxisSize: MainAxisSize.max,
                    onPressed: () => _testAppNow(context),
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

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}