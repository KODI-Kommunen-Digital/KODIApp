import 'package:flutter/foundation.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

class MatomoService {
  MatomoService._({MatomoTracker? tracker})
      : _tracker = tracker ?? MatomoTracker.instance;

  static final MatomoService instance = MatomoService._();

  final MatomoTracker _tracker;

  bool _isInitialized = false;

  Future<void> initialize({
    required String siteId,
    required String url,
  }) async {
    if (_isInitialized || _tracker.initialized) {
      _isInitialized = true;
      return;
    }

    try {
      await _tracker.initialize(
        siteId: siteId,
        url: url,
        verbosityLevel: kDebugMode ? Level.all : Level.off,
      );
      _isInitialized = true;
      if (kDebugMode) {
        debugPrint('Matomo initialized: siteId=$siteId url=$url');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Matomo initialize failed: $e');
      }
      rethrow;
    }
  }

  Future<void> trackEvent({
    required String category,
    required String action,
    String? name,
    num? value,
  }) async {
    if (!_isInitialized && !_tracker.initialized) {
      if (kDebugMode) {
        debugPrint('Matomo skipped event: tracker not initialized');
      }
      return;
    }

    try {
      _tracker.trackEvent(
        eventInfo: EventInfo(
          category: category,
          action: action,
          name: name,
          value: value,
        ),
      );
      await _tracker.dispatchActions();
      if (kDebugMode) {
        debugPrint('Matomo event sent: $category | $action | $name');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Matomo trackEvent failed: $e');
      }
    }
  }
}
