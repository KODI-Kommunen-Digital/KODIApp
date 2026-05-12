import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Converts the fixed server dispatch time (15:00 UTC) to the device's local
/// timezone. Returns "HH:mm Uhr" for German, "hh:mm AM/PM" for all others.
String wasteNotificationLocalTime({String languageCode = 'en'}) {
  final now = DateTime.now();
  final utc = DateTime.utc(now.year, now.month, now.day, 15, 00);
  final local = utc.toLocal();
  if (languageCode == 'de') {
    return '${DateFormat('HH:mm').format(local)} Uhr';
  }
  return DateFormat('hh:mm a').format(local);
}

extension TimeParsing on TimeOfDay {
  String get viewTime {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) return '0$value';
      return value.toString();
    }

    final hourLabel = addLeadingZeroIfNeeded(hour);
    final minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }
}

extension DateView on DateTime {
  String get dateView {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get fullDateView {
    return DateFormat('EEE, MMM d, yy').format(this);
  }
}
