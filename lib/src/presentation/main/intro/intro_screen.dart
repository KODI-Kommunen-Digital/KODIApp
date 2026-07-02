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

  static const int _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _skipToWasteSetup() async {
    final prefs = await Preferences.openBox();
    await prefs.setBool(Preferences.introSkipped, true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _goToWasteSetup() async {
    final prefs = await Preferences.openBox();
    await prefs.setBool(Preferences.introSkipped, true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translate.of(context);
    final theme = Theme.of(context);
    final isGerman = Localizations.localeOf(context).languageCode == 'de';
    final isDark = theme.brightness == Brightness.dark;
    final isLastPage = _currentPage == _totalPages - 1;
    final isFirstPage = _currentPage == 0;

    String img(int n) {
      final lang = isGerman ? 'de' : 'en';
      final suffix = isDark ? '_black' : '';
      return 'assets/images/intro_screen_${n}_$lang$suffix.webp';
    }

    final pages = [
      _PageData(
        heading: t.translate('intro_p1_heading'),
        body: t.translate('intro_p1_subtitle'),
        imagePath: img(1),
      ),
      _PageData(
        heading: t.translate('intro_p3_heading'),
        body: t.translate('intro_p3_body'),
        imagePath: img(2),
      ),
      _PageData(
        heading: t.translate('intro_p2_heading'),
        body: t.translate('intro_p2_body'),
        imagePath: img(3),
      ),
      _PageData(
        heading: t.translate('intro_p5_heading'),
        body: t.translate('intro_p5_body'),
        imagePath: img(4),
      ),
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07111E) : const Color(0xFFF6F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button row at top right
            SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.centerRight,
                child: !isLastPage
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: TextButton(
                          onPressed: _skipToWasteSetup,
                          style: TextButton.styleFrom(
                            foregroundColor: theme.primaryColor,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                          ),
                          child: Text(
                            t.translate('skip'),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor,
                              decorationColor: theme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
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
            _DotIndicators(
              currentPage: _currentPage,
              totalPages: _totalPages,
              activeColor: theme.primaryColor,
            ),
            const SizedBox(height: 16),
            _BottomSection(
              isLastPage: isLastPage,
              isFirstPage: isFirstPage,
              isDark: isDark,
              t: t,
              theme: theme,
              onNext: _nextPage,
              onBack: _prevPage,
              onLetsGo: _goToWasteSetup,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageData {
  final String heading;
  final String body;
  final String imagePath;

  const _PageData({
    required this.heading,
    required this.body,
    required this.imagePath,
  });
}

class _IntroPageContent extends StatelessWidget {
  final _PageData data;

  const _IntroPageContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            data.heading,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white.withOpacity(0.7) : Colors.black54,
              height: 1.25,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            data.body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white.withOpacity(0.7) : const Color(0xFF4A4A4A),
              height: 1.6,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _DotIndicators extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;

  const _DotIndicators({
    required this.currentPage,
    required this.totalPages,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final isActive = index == currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? activeColor : activeColor.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  final bool isLastPage;
  final bool isFirstPage;
  final bool isDark;
  final dynamic t;
  final ThemeData theme;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onLetsGo;

  const _BottomSection({
    required this.isLastPage,
    required this.isFirstPage,
    required this.isDark,
    required this.t,
    required this.theme,
    required this.onNext,
    required this.onBack,
    required this.onLetsGo,
  });

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    const buttonHeight = 52.0;
    const buttonTextStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.3,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
      color: isDark ? const Color(0xFF07111E) : const Color(0xFFF6F9FC),
      child: Row(
        children: [
          if (!isFirstPage) ...[
            Expanded(
              child: SizedBox(
                height: buttonHeight,
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.primaryColor,
                    side: BorderSide(color: theme.primaryColor, width: 1.5),
                    shape: buttonShape,
                    textStyle: buttonTextStyle,
                  ),
                  child: Text(t.translate('back')),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: SizedBox(
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: isLastPage ? onLetsGo : onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: buttonShape,
                  textStyle: buttonTextStyle,
                ),
                child: Text(
                  isLastPage
                      ? t.translate('button_lets_go')
                      : t.translate('intro_btn_next'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
