import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Converts the fixed server dispatch time (15:11 UTC) to the device's local
/// timezone and returns it formatted as "hh:mm AM/PM".
String wasteNotificationLocalTime() {
  final now = DateTime.now();
  final utc = DateTime.utc(now.year, now.month, now.day, 15, 11);
  return DateFormat('hh:mm a').format(utc.toLocal());
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
