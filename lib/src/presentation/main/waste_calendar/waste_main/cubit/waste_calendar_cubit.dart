import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';

part 'waste_calendar_state.dart';

class WasteCalendarCubit extends Cubit<WasteCalendarState> {
  WasteCalendarCubit() : super(WasteCalendarLoading());

  void loadWasteCollections(int cityId, String? streetId) async {
    try {
      final result =
          await WasteCalendarRepository.loadWastePickup(cityId, streetId!);
      if (result.success) {
        final data = result.data as List<dynamic>;

        final DateTime now = DateTime.now();
        final DateTime twoWeeksFromNow = now.add(const Duration(days: 14));

        List<WasteCollection> wasteCollections = [];
        List<WasteCollection> carouselCollections = [];

        for (var item in data) {
          final collection = WasteCollection.fromJson(item);
          wasteCollections.add(collection);
          if (collection.date.isAfter(now) &&
              collection.date.isBefore(twoWeeksFromNow)) {
            carouselCollections.add(collection);
          }
        }

        emit(WasteCalendarLoaded(wasteCollections, carouselCollections));
      } else {
        emit(WasteCalendarError(
            "Failed to load waste collections: ${result.message}"));
      }
    } catch (e) {
      emit(WasteCalendarError(
          "Failed to load waste collections: ${e.toString()}"));
    }
  }

  void updateStreetId(String newStreetId) {
    loadWasteCollections(1, newStreetId);
  }

  Color getColorForType(String type) {
    switch (type) {
      case 'Biotonne Regelabfuhr':
      case 'Biotonne 2-wö.':
        return Colors.green;
      case 'Papiertonne 4-wö.':
        return Colors.blue;
      case 'Wertstofftonne oder -sack 4-wö.':
        return Colors.orange;
      case 'Weihnachtsbaumabfuhr':
        return Colors.red;
      case 'Restmülltonne 2-wö.':
      case 'Restmülltonne 4-wö.':
      case 'Restmüll-Container (wö.) für Wohnanlagen':
      case 'Restmüll-Container (2-wö.) für Wohnanlagen':
      case 'Restmüll-Container (4-wö.) für Wohnanlagen':
        return Colors.grey;
      case 'Papier-Container (2-wö.) für Wohnanlagen':
      case 'Papier-Container (4-wö.) für Wohnanlagen':
        return Colors.lightBlue;
      case 'Bio-Container Regelabfuhr für Wohnanlagen':
      case 'Bio-Container (2-wö.) für Wohnanlagen':
        return Colors.lightGreen;
      case 'Wertstoff-Container (2-wö.)':
      case 'Wertstoff-Container (4-wö.)':
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }
}

extension DateTimeExtension on DateTime {
  String monthName() {
    const months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember'
    ];
    return months[month - 1];
  }

  String weekdayName() {
    const weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag'
    ];
    return weekdays[weekday - 1];
  }
}
