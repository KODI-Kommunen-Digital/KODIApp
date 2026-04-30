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
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _IntroHeader(t: t, theme: theme),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          _FeatureCard(
                            icon: Icons.newspaper_outlined,
                            title: t.translate('feature_news_title'),
                            description:
                                t.translate('feature_news_description'),
                          ),
                          const SizedBox(height: 12),
                          _FeatureCard(
                            icon: Icons.delete_outline,
                            title: t.translate('feature_waste_title'),
                            description:
                                t.translate('feature_waste_description'),
                          ),
                          const SizedBox(height: 24),
                          _MoreFeaturesSection(t: t, theme: theme),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _IntroBottomActions(
              t: t,
              onSetup: () =>
                  Navigator.pushReplacementNamed(context, Routes.introWaste),
              onSkip: () => _testAppNow(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroHeader extends StatelessWidget {
  final dynamic t;
  final ThemeData theme;

  const _IntroHeader({required this.t, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor,
            theme.primaryColor.withOpacity(0.72),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 36),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(Images.logo, height: 64),
          ),
          const SizedBox(height: 20),
          Text(
            t.translate('welcome_title'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            t.translate('welcome_subtitle'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.85),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MoreFeaturesSection extends StatelessWidget {
  final dynamic t;
  final ThemeData theme;

  const _MoreFeaturesSection({required this.t, required this.theme});

  @override
  Widget build(BuildContext context) {
    final chips = [
      _ChipData(Icons.water_drop_outlined, t.translate('feature_municipal_title')),
      _ChipData(Icons.directions_bus_outlined, t.translate('feature_mobility_title')),
      _ChipData(Icons.card_giftcard_outlined, t.translate('feature_voucher_title')),
      _ChipData(Icons.smart_toy_outlined, t.translate('feature_chatbot_title')),
      _ChipData(Icons.more_horiz, t.translate('intro_more_services'), isAccent: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.translate('intro_more_features_title'),
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          t.translate('intro_more_features_subtitle'),
          style:
              theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: chips
              .map((c) => _FeatureChip(
                    icon: c.icon,
                    label: c.label,
                    isAccent: c.isAccent,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _ChipData {
  final IconData icon;
  final String label;
  final bool isAccent;

  const _ChipData(this.icon, this.label, {this.isAccent = false});
}

class _IntroBottomActions extends StatelessWidget {
  final dynamic t;
  final VoidCallback onSetup;
  final VoidCallback onSkip;

  const _IntroBottomActions({
    required this.t,
    required this.onSetup,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            t.translate('button_setup_waste_calendar'),
            mainAxisSize: MainAxisSize.max,
            onPressed: onSetup,
          ),
          const SizedBox(height: 12),
          AppButton(
            t.translate('button_test_app'),
            type: ButtonType.outline,
            mainAxisSize: MainAxisSize.max,
            onPressed: onSkip,
          ),
        ],
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: theme.primaryColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall
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

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isAccent;

  const _FeatureChip({
    required this.icon,
    required this.label,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isAccent ? theme.colorScheme.secondary : theme.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}