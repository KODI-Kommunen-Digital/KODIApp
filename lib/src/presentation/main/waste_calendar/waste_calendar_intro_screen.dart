import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

const Color _kAccent = Color(0xFF127D86);

class WasteCalendarIntroScreen extends StatefulWidget {
  const WasteCalendarIntroScreen({super.key});

  @override
  State<WasteCalendarIntroScreen> createState() => _WasteCalendarIntroScreenState();
}

class _WasteCalendarIntroScreenState extends State<WasteCalendarIntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  void _goToSetup() {
    Navigator.pushReplacementNamed(context, Routes.introWaste);
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
      return 'assets/images/wc_intro_screen_${n}_$lang$suffix.webp';
    }

    final pages = [
      _PageData(
        heading: t.translate('wc_intro_p1_heading'),
        body: t.translate('wc_intro_p1_body'),
        imagePath: img(1),
      ),
      _PageData(
        heading: t.translate('wc_intro_p2_heading'),
        body: t.translate('wc_intro_p2_body'),
        imagePath: img(2),
      ),
      _PageData(
        heading: t.translate('wc_intro_p3_heading'),
        body: t.translate('wc_intro_p3_body'),
        imagePath: img(3),
      ),
      _PageData(
        heading: t.translate('wc_intro_p4_heading'),
        body: t.translate('wc_intro_p4_body'),
        imagePath: img(4),
      ),
    ];

    final currentData = pages[_currentPage];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07111E) : const Color(0xFFF6F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button row (top right, hidden on last page)
            SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.centerRight,
                child: !isLastPage
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: TextButton(
                          onPressed: _goToSetup,
                          style: TextButton.styleFrom(
                            foregroundColor: _kAccent,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                          ),
                          child: Text(
                            t.translate('skip'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: _kAccent,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            // Swipeable image area
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.asset(pages[index].imagePath),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Dot indicators
            SizedBox(
              height: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPages, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? _kAccent : _kAccent.withOpacity(0.18),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  currentData.heading,
                  key: ValueKey('h$_currentPage'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white.withOpacity(0.7) : Colors.black54,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  currentData.body,
                  key: ValueKey('b$_currentPage'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white.withOpacity(0.7) : const Color(0xFF4A4A4A),
                    height: 1.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: isLastPage
                  ? SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _goToSetup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kAccent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                        child: Text(t.translate('wc_intro_btn_setup')),
                      ),
                    )
                  : Row(
                      children: [
                        if (!isFirstPage) ...[
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: OutlinedButton(
                                onPressed: _prevPage,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _kAccent,
                                  side: const BorderSide(color: _kAccent, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                child: Text(t.translate('back')),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _kAccent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              child: Text(t.translate('intro_btn_next')),
                            ),
                          ),
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
