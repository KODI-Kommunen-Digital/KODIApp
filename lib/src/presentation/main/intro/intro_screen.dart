// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';

import '../../../utils/translate.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({super.key});

  @override
  State<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const int _totalPages = 5;
  static const int _dotsPageCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _skipToHome() async {
    final prefs = await Preferences.openBox();
    await prefs.setKeyValue(
        Preferences.receiveWasteCalendarNotification, 'false');
    await prefs.setBool(Preferences.isWasteCalendarSkipped, true);
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOut,
    );
  }

  void _goToWasteSetup() {
    Navigator.pushReplacementNamed(context, Routes.introWaste);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translate.of(context);
    final theme = Theme.of(context);
    final isLastPage = _currentPage == _totalPages - 1;

    final List<_PageData> pages = [
      _PageData(
        t1: t.translate('intro_tagline'),
        t2: t.translate('intro_page1_t2'),
        t3: t.translate('intro_page1_t3'),
        imagePath: 'assets/images/intro_image_1.png',
      ),
      _PageData(
        t1: t.translate('intro_tagline'),
        t2: t.translate('intro_page2_t2'),
        t3: t.translate('intro_page2_t3'),
        imagePath: 'assets/images/intro_image_2.png',
      ),
      _PageData(
        t1: t.translate('intro_tagline'),
        t2: t.translate('intro_page3_t2'),
        t3: t.translate('intro_page3_t3'),
        imagePath: 'assets/images/intro_image_3.png',
      ),
      _PageData(
        t1: t.translate('intro_tagline'),
        t2: t.translate('intro_page4_t2'),
        t3: t.translate('intro_page4_t3'),
        imagePath: 'assets/images/intro_image_4.png',
      ),
      _PageData(
        t1: null,
        t2: t.translate('intro_page5_t2'),
        t3: t.translate('intro_page5_t3'),
        imagePath: 'assets/images/intro_image_5.png',
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemBuilder: (context, index) =>
                    _IntroPageContent(data: pages[index]),
              ),
            ),
            // Dots sit just below the page content
            SizedBox(
              height: 28,
              child: isLastPage
                  ? null
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_dotsPageCount, (index) {
                        final isActive = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive
                                ? theme.primaryColor
                                : theme.primaryColor.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
            ),
            _BottomSection(
              isLastPage: isLastPage,
              t: t,
              theme: theme,
              onNext: _nextPage,
              onSetupWaste: _goToWasteSetup,
              onSkip: _skipToHome,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageData {
  final String? t1;
  final String t2;
  final String t3;
  final String imagePath;

  const _PageData({
    this.t1,
    required this.t2,
    required this.t3,
    required this.imagePath,
  });
}

class _IntroPageContent extends StatelessWidget {
  final _PageData data;

  const _IntroPageContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // t1 slot — always occupies same height for layout consistency
          SizedBox(
            height: 18,
            child: data.t1 != null
                ? Text(
                    data.t1!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  )
                : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: Image.asset(
              data.imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            data.t2,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              height: 1.25,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            data.t3,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.55,
              fontWeight: FontWeight.w200,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  final bool isLastPage;
  final dynamic t;
  final ThemeData theme;
  final VoidCallback onNext;
  final VoidCallback onSetupWaste;
  final VoidCallback onSkip;

  const _BottomSection({
    required this.isLastPage,
    required this.t,
    required this.theme,
    required this.onNext,
    required this.onSetupWaste,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary action button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: isLastPage ? onSetupWaste : onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              child: Text(
                isLastPage
                    ? t.translate('button_setup_waste_calendar')
                    : t.translate('next'),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Secondary skip button
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              foregroundColor: theme.primaryColor,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              t.translate('button_test_app'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: theme.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}