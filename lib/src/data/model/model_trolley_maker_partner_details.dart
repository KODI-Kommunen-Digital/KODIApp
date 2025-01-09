class TrolleyMakerPartnerDetailsInfo {
  final bool closedMonday;
  final bool closedTuesday;
  final bool closedWednesday;
  final bool closedThursday;
  final bool closedFriday;
  final bool closedSaturday;
  final bool closedSunday;
  final OpeningHours openingHours;
  final String companyOpenHoursAdditionalInfo;
  final bool companyOpenHoursOnlyByArrangement;
  final String companyName;
  final String category;
  final String city;
  final String street;
  final String zip;
  final String country;
  final String phone;
  final String email;
  final String website;
  final double latitude;
  final double longitude;
  final bool anyBonusActive;
  final String logoUrl;

  TrolleyMakerPartnerDetailsInfo({
    required this.closedMonday,
    required this.closedTuesday,
    required this.closedWednesday,
    required this.closedThursday,
    required this.closedFriday,
    required this.closedSaturday,
    required this.closedSunday,
    required this.openingHours,
    required this.companyOpenHoursAdditionalInfo,
    required this.companyOpenHoursOnlyByArrangement,
    required this.companyName,
    required this.category,
    required this.city,
    required this.street,
    required this.zip,
    required this.country,
    required this.phone,
    required this.email,
    required this.website,
    required this.latitude,
    required this.longitude,
    required this.anyBonusActive,
    required this.logoUrl,
  });

  static String standardizePhoneNumber(String phone) {
    if (phone.isEmpty) return '';

    phone = phone.replaceAll(RegExp(r'\D'), '');

    if (phone.startsWith('49')) {
      return '49${phone.substring(2)}';
    }

    if (phone.startsWith('0')) {
      return '49${phone.substring(1)}';
    }

    return '49$phone';
  }

  factory TrolleyMakerPartnerDetailsInfo.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerPartnerDetailsInfo(
      closedMonday: json['closedMonday'] ?? false,
      closedTuesday: json['closedTuesday'] ?? false,
      closedWednesday: json['closedWednesday'] ?? false,
      closedThursday: json['closedThursday'] ?? false,
      closedFriday: json['closedFriday'] ?? false,
      closedSaturday: json['closedSaturday'] ?? false,
      closedSunday: json['closedSunday'] ?? false,
      openingHours: OpeningHours.fromJson(json['openingHours']),
      companyOpenHoursAdditionalInfo:
          json['companyOpenHoursAdditionalInfo'] ?? '',
      companyOpenHoursOnlyByArrangement:
          json['companyOpenHoursOnlyByArrangement'] ?? false,
      companyName: json['companyName'] ?? '',
      category: json['category'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      zip: json['zip'] ?? '',
      country: json['country'] ?? '',
      phone: standardizePhoneNumber(json['phone'] ?? ''),
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      anyBonusActive: json['anyBonusActive'] ?? false,
      logoUrl: json['logoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'closedMonday': closedMonday,
      'closedTuesday': closedTuesday,
      'closedWednesday': closedWednesday,
      'closedThursday': closedThursday,
      'closedFriday': closedFriday,
      'closedSaturday': closedSaturday,
      'closedSunday': closedSunday,
      'openingHours': openingHours.toJson(),
      'companyOpenHoursAdditionalInfo': companyOpenHoursAdditionalInfo,
      'companyOpenHoursOnlyByArrangement': companyOpenHoursOnlyByArrangement,
      'companyName': companyName,
      'category': category,
      'city': city,
      'street': street,
      'zip': zip,
      'country': country,
      'phone': phone,
      'email': email,
      'website': website,
      'latitude': latitude,
      'longitude': longitude,
      'anyBonusActive': anyBonusActive,
      'logoUrl': logoUrl,
    };
  }
}

class OpeningHours {
  final List<TimeSlot> mon;
  final List<TimeSlot> tue;
  final List<TimeSlot> wed;
  final List<TimeSlot> thu;
  final List<TimeSlot> fri;
  final List<TimeSlot> sat;
  final List<TimeSlot> sun;

  OpeningHours({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      mon: (json['mon'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      tue: (json['tue'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      wed: (json['wed'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      thu: (json['thu'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      fri: (json['fri'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      sat: (json['sat'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      sun: (json['sun'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mon': mon.map((e) => e.toJson()).toList(),
      'tue': tue.map((e) => e.toJson()).toList(),
      'wed': wed.map((e) => e.toJson()).toList(),
      'thu': thu.map((e) => e.toJson()).toList(),
      'fri': fri.map((e) => e.toJson()).toList(),
      'sat': sat.map((e) => e.toJson()).toList(),
      'sun': sun.map((e) => e.toJson()).toList(),
    };
  }
}

class TimeSlot {
  final String start;
  final String end;

  TimeSlot({required this.start, required this.end});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      start: json['start'] ?? '',
      end: json['end'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}
